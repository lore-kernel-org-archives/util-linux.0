Return-Path: luto@amacapital.net
MIME-Version: 1.0
In-Reply-To: <CALCETrVrmkzGgLniSc8JdR7_Xtus61vR169EOzi=Ue-r7TqwUw@mail.gmail.com>
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
 <50AFE72B.1010908@draigBrady.com> <20121126100822.GA4224@x2.net.home> <CALCETrVrmkzGgLniSc8JdR7_Xtus61vR169EOzi=Ue-r7TqwUw@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 26 Nov 2012 17:39:17 -0800
Message-ID: <CALCETrUjM+g8D-wz9pH34Yw-OBP_3Mz8hv2a=nb564Dz85OyUg@mail.gmail.com>
Subject: Re: [PATCH] Add no_new_privs
To: Karel Zak <kzak@redhat.com>
Cc: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 26, 2012 at 11:03 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Nov 26, 2012 at 2:08 AM, Karel Zak <kzak@redhat.com> wrote:
>>
>>  It would be nice to have prctl(1) implemented like prlimit(1), it
>>  means to support --set as well as --get operations.
>>
>>   prctl --set-endian=big --set-name=foo
>>
>>   prctl --pid 123    # return all --get-*
>>
>>   prctl --get-name --pid 123
>>
>>> I also notice the similar capsh(1) program for doing
>>> so with capabilities. Perhaps these could be merged
>>> to a setpriv(1) command or something for tweaking all
>>> these knobs before exec?
>>
>>  hmm.. capsh(1) is libcap baby and it probably makes sense to maintain
>>  it on the same place like libcap.
>
> Taking a quick look through prctl:
>

>
> PR_GET/SET_CHILD_SUBREAPER: Very useful, but probably wants to be its own tool
>

For example, the tool below would probably be quite handy, but I don't
think it would make too much sense as part of a hypothetical prctl(1).
 (I'll send this as a proper patch later on, after I make its
interface a little less silly.)

---wait_all_descendents.c---

#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <unistd.h>
#include <errno.h>

static volatile sig_atomic_t exec_failed = 0;
static volatile int exec_errno;

static int wait_all_children(pid_t child_pid)
{
	while (1) {
		siginfo_t si;
		if (waitid(P_ALL, 0, &si, WEXITED) != 0) {
			if (errno == ECHILD) {
				if (child_pid)
					fprintf(stderr, "Warning: child never exited\n");
				return 0;
			} else {
				perror("waitid");
				return 1;
			}
		}

		if (si.si_pid == child_pid) {
			child_pid = 0;
			fprintf(stderr, "Immediate child exited\n");
		}
	}
}

int main(int argc, char **argv)
{
	if (argc < 2) {
		printf("Usage: wait_descendents PROGRAM [ARGS]...\n");
		return 1;
	}

	if (signal(SIGCHLD, SIG_DFL)) {
		perror("signal");
		return 127;
	}

	if (prctl(PR_SET_CHILD_SUBREAPER, 1, 0, 0, 0) != 0) {
		perror("PR_SET_CHILD_SUBREAPER");
		return 127;
	}

	pid_t child_pid = vfork();
	if (child_pid == -1) {
		perror("fork");
		return 1;
	} else if (child_pid == 0) {
		/* We're the child. */
		execvp(argv[1], argv + 1);
		exec_failed = 1;
		exec_errno = errno;
		_exit(1);
	} else {
		if (exec_failed) {
			errno = exec_errno;
			perror(argv[1]);
			return 127;
		}

		return wait_all_children(child_pid);
	}
}
