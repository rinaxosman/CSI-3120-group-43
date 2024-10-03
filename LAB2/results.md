# Test 1 (test1.png) - No Overlaps

How many jobs do you want to schedule? 2
For job 1, please enter the following details:
- Start Time (hours): 9
- Start Time (minutes): 30
- Duration (minutes): 60
- Priority: 3
For job 2, please enter the following details:
- Start Time (hours): 11
- Start Time (minutes): 0
- Duration (minutes): 45
- Priority: 5
Choose a scheduling strategy (1 for No Overlaps, 2 for Max Priority, 3 for Minimize Idle Time): 1

## Test 1 - Output

Job scheduled: Start Time = 570 minutes, Duration = 60 minutes, Priority = 3
Job scheduled: Start Time = 660 minutes, Duration = 45 minutes, Priority = 5

    In the No Overlaps strategy, jobs are scheduled to ensure no overlap in their start and end times. The jobs were sorted by their start time (9:30 for Job 1 and 11:00 for Job 2). Since Job 1 finishes at 10:30 (60 minutes after 9:30), there’s no overlap with Job 2 (which starts at 11:00) so both jobs were scheduled successfully without any changes.

# Test 2 (test2.png) - Max priority

How many jobs do you want to schedule? 3
For job 1, please enter the following details:
- Start Time (hours): 8
- Start Time (minutes): 0
- Duration (minutes): 90
- Priority: 1
For job 2, please enter the following details:
- Start Time (hours): 9
- Start Time (minutes): 30
- Duration (minutes): 60
- Priority: 3
For job 3, please enter the following details:
- Start Time (hours): 11
- Start Time (minutes): 0
- Duration (minutes): 45
- Priority: 2
Choose a scheduling strategy (1 for No Overlaps, 2 for Max Priority, 3 for Minimize Idle Time): 2

## Test 2 - Output

Job scheduled: Start Time = 570 minutes, Duration = 60 minutes, Priority = 3
Job scheduled: Start Time = 660 minutes, Duration = 45 minutes, Priority = 2
Job scheduled: Start Time = 480 minutes, Duration = 90 minutes, Priority = 1

    In the Max Priority strategy, jobs are sorted by priority instead of start time. Job 2, with the highest priority (3), was scheduled first, followed by Job 3 (priority 2), and finally Job 1 (priority 1), regardless of their start times. The start times are preserved from the input, but jobs are displayed in priority order (highest to lowest).