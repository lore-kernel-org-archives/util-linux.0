Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20121220092439.GA30947@x2.net.home>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
	<20121220092439.GA30947@x2.net.home>
Date: Thu, 20 Dec 2012 11:17:49 +0000
Message-ID: <CAG27Bk2BCnT0vMBShPPLQCCGJbj+Lgj9OajnCJmo_rrw1GFKdA@mail.gmail.com>
Subject: Re: [PATCH] sys-tools: Add setns utility to sys-tools
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 20, 2012 at 9:24 AM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Dec 19, 2012 at 02:06:46PM -0500, Neil Horman wrote:
>> Like the unshare command, which lets a user from the command line detach from
>> specific namespaces of the parent process, and execute a command, setns provides
>> a frontend to the setns(2) syscall, which allows a user to migrate a process to
>> the namespaces of other processes, prior to calling exec on a command.
>
> Do we really need a new command? Can't we extend unshare(1)?

IMHO adding functionality to existing command is probably better. What
comes to adjusted patch from yesterday it is there just in case new
command becomes more preferred option.

>  create a new namespace:
>
>     unshare --{mount,ipc,...} <program> [<args>]
>
>  move to already existing namespace:
>
>     unshare --namespace <pid> --{ipc,...} <program> [<args>]
>
>
> From user's point of view in both cases the <program> will be unshared
> from the current namespace so the util name seems OK.
>
> IMHO it seems better then add a new command.
>
>
> If you really want to support direct namespace paths (/proc/<pid>/ns/<nsname>)
> then we can use
>
>     unshare --namespace <path> <program> [<args>]
>
> anyway this way should be optional and not required. It's naive to
> expect that everyone remembers and understands all the /proc tricks.

No matter where the support for setns(2) is added I think there is
need for two things.

1) Builds must not break when setns(2) does not exist.
2) Good documentation.

For the second some sort of explanation and/or example when and why
anyone would use this would be nice.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
