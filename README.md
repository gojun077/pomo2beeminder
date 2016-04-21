A bash script that sends data to a Beeminder pomodoro goal.
It is intended to be used with timer programs like xfce-timer-plugin
or pystopwatch that can launch commands when a timer finishes a
countdown.

In my timer applications I am using a default pomodoro length
of 25 minutes. I also have double-length pomodoro sessions
that are 50 minutes in length. In the latter case, another
script will increment the pomodoro goal by "^ 2" instead of
1.
