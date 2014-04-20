Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140416101308.GG5786@x2.net.home>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
	<1397560535-14622-8-git-send-email-kerolasa@iki.fi>
	<20140416101308.GG5786@x2.net.home>
Date: Sun, 20 Apr 2014 10:53:47 +0100
Message-ID: <CAG27Bk0oL7rEh-uDH7A6J5sofE+XrXcK-kavtOBiXQiF0JCjwA@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests: check kill all user processes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Bernhard Voelker <mail@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 16 April 2014 11:13, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Apr 15, 2014 at 12:15:33PM +0100, Sami Kerola wrote:
>> +ts_check_test_command "$TS_CMD_KILL"
>> +ts_check_test_command "$TS_CMD_SU"
>
>  ts_check_test_command "TS_HELPER_SIGRECEIVE"

These are added.

>> +if ! getent passwd nobody >/dev/null; then
>> +     ts_skip "no nobody user"
>> +fi
>> +
>> +TEST_PID=''
>> +TS_CWD="${0%/*}"
>
> Please, use $TS_OUTDIR. The tests should not write to another places.
> The output/ is the directory that clean up our build system.

These are removed.

>> +HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
>> +ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
>> +trap "rm -f $HELPER_SYMLINK" 0
>> +
>> +su nobody -s /bin/sh -c "$HELPER_SYMLINK $TS_CWD/nobody" >> "$TS_OUTPUT" 2>&1 &
>
> I don't understand this idea, on my system Mr.Nobody can not write
> to my directories.
>
> It would be also better to add --setgit and --setuid to the helper to
> avoid extra su(1) process, then you can use TEST_PID=$!

The --setuid is added, which made me to scratch my head for a moment
why it behaved the way it did, resulting to a patch fixing
lib/procutils

https://github.com/kerolasa/lelux-utiliteetit/commit/08b7b1c60eaeddbf25ef28f2a7d1d0e6778a6af8

>> +# test_sigreceive needs time to start up
>> +for i in 0.01 0.1 1 1 1 1; do
>> +     test -f "$TS_CWD/nobody" && { up=1; break; }
>> +     sleep $i
>> +done
>
> The question is if we really need to use the PID files. Would be
> possible to use test_sigreceive that does not write anything?
>
> You can for example to use
>
>    awk '/SigCgt/ { print $2}' /proc/<pid>/status
>
> to check if the signal handlers are already initialized (the final
> mask is 800000027ffbfeff on my system).

That is a much better way to determine if the process is ready to be
killed. Implemented in my git, and I have only one remaining question.
Would you prefer me to send the patch set again or is review from
remote branch OK? The biggest change is use of SigCgt, that is done
the same way in all scripts and can be seen for instance looking this
change.

https://github.com/kerolasa/lelux-utiliteetit/commit/08b7b1c60eaeddbf25ef28f2a7d1d0e6778a6af8

--- pull --
The following changes since commit 9348ef251102eefdf9e352616393778f0950720f:

  libfdisk: (gpt) implement 'fix order' commnad (2014-04-18 14:00:39 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git kill-tests-v3

for you to fetch changes up to 08b7b1c60eaeddbf25ef28f2a7d1d0e6778a6af8:

  lib/procutils: notice setuid() process ownership changes (2014-04-20
10:36:05 +0100)

----------------------------------------------------------------
Sami Kerola (10):
      kill: make options --pid and --queue mutually exclusive
      kill: remove unnecessary indirection
      tests: add signal receiver program
      tests: check kill is converting signals names correctly
      tests: check various ways to specify kill signal
      tests: check kill print pid option
      tests: check kill all user processes
      kill: add --verbose option to display what is killed
      lib/procutils: reset errno before strtol() call
      lib/procutils: notice setuid() process ownership changes

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
