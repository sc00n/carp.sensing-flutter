/*
 * Copyright 2018-2021 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of runtime;

/// Returns the relevant [TriggerExecutor] based on the type of [trigger].
TriggerExecutor getTriggerExecutor(
    SmartphoneDeployment deployment, Trigger trigger) {
  switch (trigger.runtimeType) {
    case ImmediateTrigger:
      return ImmediateTriggerExecutor(deployment);
    case OneTimeTrigger:
      return OneTimeTriggerExecutor(deployment);
    case DelayedTrigger:
      return DelayedTriggerExecutor(deployment);
    case ElapsedTimeTrigger:
      return ElapsedTimeTriggerExecutor(deployment);
    case ElapsedTimeTrigger:
      return ElapsedTimeTriggerExecutor(deployment);
    case IntervalTrigger:
      return IntervalTriggerExecutor(deployment);
    case PeriodicTrigger:
      return PeriodicTriggerExecutor(deployment);
    case DateTimeTrigger:
      return DateTimeTriggerExecutor(deployment);
    case RecurrentScheduledTrigger:
      return RecurrentScheduledTriggerExecutor(deployment);
    case CronScheduledTrigger:
      return CronScheduledTriggerExecutor(deployment);
    case SamplingEventTrigger:
      return SamplingEventTriggerExecutor(deployment);
    case ConditionalSamplingEventTrigger:
      return ConditionalSamplingEventTriggerExecutor(deployment);
    case ConditionalPeriodicTrigger:
      return ConditionalPeriodicTriggerExecutor(deployment);
    case RandomRecurrentTrigger:
      return RandomRecurrentTriggerExecutor(deployment);
    case PassiveTrigger:
      return PassiveTriggerExecutor(deployment);
    default:
      warning(
          "Unknown trigger used - cannot find a TriggerExecutor for the trigger of type '${trigger.runtimeType}'. "
          "Using an 'ImmediateTriggerExecutor' instead.");
      return ImmediateTriggerExecutor(deployment);
  }
}

// ---------------------------------------------------------------------------------------------------------
// TRIGGER EXECUTORS
// ---------------------------------------------------------------------------------------------------------

/// Responsible for handling the execution of a [Trigger].
///
/// This is an abstract class. For each specific type of [Trigger],
/// a corresponding implementation of this class exists.
abstract class TriggerExecutor<TConfig extends Trigger>
    extends AggregateExecutor<TConfig> {
  // Trigger get trigger => configuration!;

  TriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  /// An ordered list of timestamp generated by this trigger for a
  /// given period. This is mainly used for persistently scheduling
  /// a list of [AppTask]s from this trigger.
  List<DateTime> getSchedule(DateTime from, DateTime to) => [];

  @override
  void onInitialize() {
    // No initialize needed pr. default.
  }

  // /// Returns a list of the running probes in this [TriggerExecutor].
  // /// This is a combination of the running probes in all task executors.
  // List<Probe> get probes {
  //   List<Probe> _probes = [];
  //   executors.forEach((executor) {
  //     if (executor is TaskExecutor) {
  //       executor.probes.forEach((probe) {
  //         _probes.add(probe);
  //       });
  //     }
  //   });
  //   return _probes;
  // }
}

/// Executes a [ImmediateTrigger], i.e. starts sampling immediately.
class ImmediateTriggerExecutor extends TriggerExecutor<Trigger> {
  ImmediateTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) => [DateTime.now()];
}

/// Executes a [OneTimeTrigger], i.e. a trigger that only runs once during a
/// study deployment.
class OneTimeTriggerExecutor extends TriggerExecutor<OneTimeTrigger> {
  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) =>
      (configuration!.hasBeenTriggered) ? [] : [from];

  OneTimeTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  Future onResume() async {
    if (!configuration!.hasBeenTriggered) {
      configuration!.triggerTimestamp = DateTime.now();
      await super.onResume();
    } else {
      info(
          "$runtimeType - one time trigger already occured at: ${configuration?.triggerTimestamp}. "
          'Will not trigger now.');
    }
  }
}

/// Executes a [PassiveTrigger].
class PassiveTriggerExecutor extends TriggerExecutor<PassiveTrigger> {
  PassiveTriggerExecutor(SmartphoneDeployment deployment) : super(deployment) {
    configuration!.executor = ImmediateTriggerExecutor(deployment);
    group.add(configuration!.executor.data);
  }

  // Forward to the embedded trigger executor
  void onInitialize() =>
      configuration!.executor.initialize(configuration as Trigger);

  // No-op methods since a PassiveTrigger can only be resumed/paused
  // using the resume/pause methods on the PassiveTrigger.
  Future onResume() async {}
  Future onPause() async {}

  // Forward to the embedded trigger executor
  Future onRestart({Measure? measure}) async =>
      configuration!.executor.restart();
  Future onStop() async => configuration!.executor.stop();

  // List<Probe> get probes => trigger.executor.probes;
}

/// Executes a [DelayedTrigger], i.e. resumes sampling after the specified delay.
/// Once started, it can be paused / resumed as any other [Executor].
class DelayedTriggerExecutor extends TriggerExecutor<DelayedTrigger> {
  DelayedTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) {
    var dd = DateTime.now().add(configuration!.delay);
    return (dd.isAfter(from) && dd.isBefore(to)) ? [dd] : [];
  }

  @override
  Future onResume() async =>
      Timer(configuration!.delay, () => super.onResume());
}

/// Executes a [ElapsedTimeTrigger], i.e. resumes sampling after the
/// specified delay after deployment start on this phone.
///
/// Once started, this trigger executor can be paused / resumed as any
/// other [Executor].
class ElapsedTimeTriggerExecutor extends TriggerExecutor<ElapsedTimeTrigger> {
  ElapsedTimeTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment);

  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) {
    var dd = DateTime.now().add(configuration!.elapsedTime);
    return (dd.isAfter(from) && dd.isBefore(to)) ? [dd] : [];
  }

  Future onResume() async {
    if (deployment.deployed == null) {
      warning(
          '$runtimeType - this deployment does not have a start time. Cannot execute this trigger.');
    } else {
      int delay = configuration!.elapsedTime.inMilliseconds -
          (DateTime.now().millisecondsSinceEpoch -
              deployment.deployed!.millisecondsSinceEpoch);

      if (delay > 0) {
        Timer(Duration(milliseconds: delay), () => super.onResume());
      } else {
        warning(
            '$runtimeType - delay is negative, i.e. the trigger time is in the past and should have happend already.');
      }
    }
  }
}

abstract class TimerTriggerExecutor<TConfig extends Trigger>
    extends TriggerExecutor<TConfig> {
  Timer? timer;

  TimerTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  Future onPause() async {
    timer?.cancel();
    await super.onPause();
  }
}

/// Executes a [IntervalTrigger], i.e. resumes sampling on a regular basis.
class IntervalTriggerExecutor extends TimerTriggerExecutor<IntervalTrigger> {
  IntervalTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) {
    List<DateTime> schedule = [];
    DateTime timestamp = from;

    while (timestamp.isBefore(to)) {
      schedule.add(timestamp);
      timestamp = timestamp.add(configuration!.period);
    }

    return schedule;
  }

  Future onResume() async {
    timer = Timer.periodic(configuration!.period, (t) {
      super.onResume();
      Timer(const Duration(seconds: 3), () => super.onPause());
    });
  }
}

/// Executes a [PeriodicTrigger], i.e. resumes sampling on a regular basis for
/// a given period of time.
///
/// It is required that both the [period] and the [duration] of the
/// [PeriodicTrigger] is specified to make sure that this executor is properly
/// resumed and paused again.
class PeriodicTriggerExecutor extends TimerTriggerExecutor<PeriodicTrigger> {
  PeriodicTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) {
    List<DateTime> schedule = [];
    DateTime timestamp = from;

    while (timestamp.isBefore(to)) {
      schedule.add(timestamp);
      timestamp = timestamp.add(configuration!.period);
    }

    return schedule;
  }

  Future onResume() async {
    // create a recurrent timer that resume periodically
    timer = Timer.periodic(configuration!.period, (t) {
      super.onResume();
      // create a timer that pause the sampling after the specified duration.
      Timer(configuration!.duration, () {
        super.onPause();
      });
    });
  }
}

/// Executes a [DateTimeTrigger] on the specified date and time.
class DateTimeTriggerExecutor extends TimerTriggerExecutor<DateTimeTrigger> {
  DateTimeTriggerExecutor(SmartphoneDeployment deployment) : super(deployment);

  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) =>
      (configuration!.schedule.isAfter(from) &&
              configuration!.schedule.isBefore(to))
          ? [configuration!.schedule]
          : [];

  @override
  Future onResume() async {
    if (configuration!.schedule.isAfter(DateTime.now())) {
      warning('The schedule of the ScheduledTrigger cannot be in the past.');
    } else {
      var delay = configuration!.schedule.difference(DateTime.now());
      var duration = configuration?.duration;
      timer = Timer(delay, () {
        // after the waiting time (delay) is over, resume this trigger
        super.onResume();
        if (duration != null) {
          // create a timer that stop the sampling after the specified duration.
          // if the duration is null, the sampling never stops, i.e. runs forever.
          Timer(duration, () {
            stop();
          });
        }
      });
    }
  }
}

/// Executes a [RecurrentScheduledTrigger].
class RecurrentScheduledTriggerExecutor
    extends TimerTriggerExecutor<RecurrentScheduledTrigger> {
  @override
  List<DateTime> getSchedule(DateTime from, DateTime to) {
    List<DateTime> schedule = [];
    DateTime timestamp = configuration!.firstOccurrence;

    while (timestamp.isBefore(to)) {
      if (timestamp.isAfter(from)) schedule.add(timestamp);
      timestamp = timestamp.add(configuration!.period);
    }

    return schedule;
  }

  RecurrentScheduledTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment);

  Future onResume() async {
    // check if there is a remembered trigger date
    if (configuration!.remember) {
      String? _savedFirstOccurrence =
          Settings().preferences!.getString(configuration!.triggerId!);
      debug('savedFirstOccurrence : $_savedFirstOccurrence');

      if (_savedFirstOccurrence != null) {
        DateTime savedDate = DateTime.tryParse(_savedFirstOccurrence)!;
        if (savedDate.isBefore(DateTime.now())) {
          debug(
              'There is a saved timestamp in the past - resuming this trigger now: ${DateTime.now().toString()}.');
          executors.forEach((executor) => executor.resume());
          // create a timer that pause the sampling after the specified duration.
          Timer(configuration!.duration, () {
            executors.forEach((executor) => executor.pause());
          });
        }
      }

      // save the day of the first occurrence for later use
      await Settings().preferences!.setString(configuration!.triggerId!,
          configuration!.firstOccurrence.toUtc().toString());
      debug(
          'saving firstOccurrence : ${configuration!.firstOccurrence.toUtc().toString()}');
    }

    // below is 'normal' (i.e., non-remember) behavior
    Duration _delay = configuration!.firstOccurrence.difference(DateTime.now());
    debug('delay: $_delay');
    if (configuration!.end == null ||
        configuration!.end!.isAfter(DateTime.now())) {
      Timer(_delay, () async {
        debug('delay finished, now resuming...');
        if (configuration!.remember) {
          // replace the entry of the first occurrence to the next occurrence date
          DateTime nextOccurrence = DateTime.now().add(configuration!.period);
          await Settings().preferences!.setString(
              configuration!.triggerId!, nextOccurrence.toUtc().toString());
          debug('saving nextOccurrence: $nextOccurrence');
        }
        await super.onResume();
      });
    }
  }
}

/// Executes a [CronScheduledTrigger] based on the specified cron job.
class CronScheduledTriggerExecutor
    extends TriggerExecutor<CronScheduledTrigger> {
  late cron.Cron _cron;
  cron.ScheduledTask? _scheduledTask;

  CronScheduledTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment) {
    _cron = cron.Cron();
  }

  Future onResume() async {
    debug('creating cron job : $configuration');
    var _schedule = cron.Schedule.parse(configuration!.cronExpression);
    _scheduledTask = _cron.schedule(_schedule, () async {
      debug('resuming cron job : ${DateTime.now().toString()}');
      await super.onResume();
      Timer(configuration!.duration, () => super.onPause());
    });
  }

  Future onPause() async {
    await _scheduledTask?.cancel();
    await super.onPause();
  }
}

/// Executes a [SamplingEventTrigger] based on the specified
/// [SamplingEventTrigger.measureType] and [SamplingEventTrigger.resumeCondition].
class SamplingEventTriggerExecutor
    extends TriggerExecutor<SamplingEventTrigger> {
  late StreamSubscription<DataPoint> _subscription;

  SamplingEventTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment);

  Future onResume() async {
    // listen for events of the specified type
    _subscription = ProbeRegistry()
        .eventsByType(configuration!.measureType)
        .listen((dataPoint) {
      if ((configuration!.resumeCondition == null) ||
          (dataPoint.carpBody as Datum)
              .equivalentTo(configuration!.resumeCondition)) super.onResume();
      if (configuration!.pauseCondition != null &&
          (dataPoint.carpBody as Datum)
              .equivalentTo(configuration!.pauseCondition)) super.onPause();
    });
  }

  Future onPause() async {
    await _subscription.cancel();
    await super.onPause();
  }
}

/// Executes a [ConditionalSamplingEventTrigger] based on the specified
/// [ConditionalSamplingEventTrigger.measureType] and their
/// [ConditionalSamplingEventTrigger.resumeCondition] and
/// [ConditionalSamplingEventTrigger.pauseCondition].
class ConditionalSamplingEventTriggerExecutor
    extends TriggerExecutor<ConditionalSamplingEventTrigger> {
  StreamSubscription<DataPoint>? _subscription;

  ConditionalSamplingEventTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment);

  Future onResume() async {
    // listen for event of the specified type and resume/pause as needed
    _subscription = ProbeRegistry()
        .eventsByType(configuration!.measureType)
        .listen((dataPoint) {
      if (configuration!.resumeCondition != null &&
          configuration!.resumeCondition!(dataPoint)) super.onResume();
      if (configuration!.pauseCondition != null &&
          configuration!.pauseCondition!(dataPoint)) super.onPause();
    });
  }

  Future onPause() async {
    await _subscription?.cancel();
    await super.onPause();
  }
}

/// Executes a [ConditionalPeriodicTrigger] based on the specified
/// [ConditionalPeriodicTrigger.period] and their
/// [ConditionalPeriodicTrigger.resumeCondition] and
/// [ConditionalPeriodicTrigger.pauseCondition].
class ConditionalPeriodicTriggerExecutor
    extends TimerTriggerExecutor<ConditionalPeriodicTrigger> {
  ConditionalPeriodicTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment);

  Future onResume() async {
    // create a recurrent timer that checks the conditions periodically
    timer = Timer.periodic(configuration!.period, (_) {
      if (configuration!.resumeCondition != null &&
          configuration!.resumeCondition!()) super.onResume();
      if (configuration!.pauseCondition != null &&
          configuration!.pauseCondition!()) super.onPause();
    });
  }
}

/// Executes a [RandomRecurrentTrigger] triggering N times per day within a
/// defined period of time.
class RandomRecurrentTriggerExecutor
    extends TriggerExecutor<RandomRecurrentTrigger> {
  final cron.Cron _cron = cron.Cron();
  late cron.ScheduledTask _scheduledTask;
  List<Timer> _timers = [];

  RandomRecurrentTriggerExecutor(SmartphoneDeployment deployment)
      : super(deployment);

  Time get startTime => configuration!.startTime;
  Time get endTime => configuration!.endTime;
  int get minNumberOfTriggers => configuration!.minNumberOfTriggers;
  int get maxNumberOfTriggers => configuration!.maxNumberOfTriggers;
  Duration get duration => configuration!.duration;

  /// Get a random number of samples for the day
  int get numberOfSampling =>
      Random().nextInt(maxNumberOfTriggers) + minNumberOfTriggers;

  /// Get N random times between startTime and endTime
  List<Time> get samplingTimes {
    List<Time> _samplingTimes = [];
    for (int i = 0; i <= numberOfSampling; i++) {
      _samplingTimes.add(randomTime);
    }
    debug('Random sampling times: $_samplingTimes');
    return _samplingTimes;
  }

  /// Get a random time between startTime and endTime
  Time get randomTime {
    Time randomTime = Time();
    do {
      int randomHour = startTime.hour +
          ((endTime.hour - startTime.hour == 0)
              ? 0
              : Random().nextInt(endTime.hour - startTime.hour));
      int randomMinutes = Random().nextInt(60);
      randomTime = Time(hour: randomHour, minute: randomMinutes);
    } while (!(randomTime.isAfter(startTime) && randomTime.isBefore(endTime)));

    return randomTime;
  }

  String get todayString {
    DateTime now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  String get tag => 'rrte.$todayString';

  Future onResume() async {
    // sampling might be resumed after [startTime] or the app wasn't running at [startTime]
    // therefore, first check if the random timers have been scheduled for today
    if (Time.now().isAfter(startTime)) {
      bool hasBeenScheduledForToday = Settings().preferences!.containsKey(tag);
      if (!hasBeenScheduledForToday) {
        debug(
            '$runtimeType - timers has not been scheduled for today ($todayString) - scheduling now');
        _scheduleTimers();
      }
    }

    // set up a cron job that generates the random triggers once pr day at [startTime]
    final String cronJob = '${startTime.minute} ${startTime.hour} * * *';
    debug('$runtimeType - creating cron job : $cronJob');

    _scheduledTask = _cron.schedule(cron.Schedule.parse(cronJob), () async {
      debug('$runtimeType - resuming cron job : ${DateTime.now().toString()}');
      _scheduleTimers();
    });
  }

  void _scheduleTimers() {
    // empty the list of timers.
    _timers = [];

    // get a random number of trigger time for today, and for each set up a
    // timer that triggers the super.onResum() method.
    samplingTimes.forEach((time) {
      // find the delay - note, that none of the delays can be negative,
      // since we are at [startTime] or after
      Duration delay = time.difference(startTime);
      debug('$runtimeType - setting up timer for : $time, delay: $delay');
      Timer timer = Timer(delay, () async {
        await super.onResume();
        // now set up a timer that waits until the sampling duration ends
        Timer(duration, () => super.onPause());
      });
      _timers.add(timer);
    });

    // mark this day as scheduled
    Settings().preferences!.setBool(tag, true);
  }

  Future onPause() async {
    // cancel all the timer that might have been started
    for (var timer in _timers) {
      timer.cancel();
    }
    // cancel the daily cronn job
    await _scheduledTask.cancel();
    await super.onPause();
  }
}
