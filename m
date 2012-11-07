Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20121105164251.GA3799@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
	<20121105164251.GA3799@x2.net.home>
Date: Wed, 7 Nov 2012 09:40:16 +0000
Message-ID: <CAG27Bk2ZbPH+Zfbt0vR_GLyLuZoy7QHv-b96WtpEFm963DpD9w@mail.gmail.com>
Subject: Re: [PATCH 00/13] make ipcs to use proc
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 5, 2012 at 4:42 PM, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Oct 14, 2012 at 09:22:12PM +0100, Sami Kerola wrote:
>> Sami Kerola (13):

Hi Karel and others,

>  I have created ipc branch at hithub and applied some of the patches
>  (unfortunately with many changes).

I would not call code review unfortunate, especially when it causes
changes to code that will make it better.

>  Unfortunately I have no more time to play with this stuff this week,

Open source is supposed to be fun. Take your time, so will I. Getting
all IPC related fixes done will most likely take several weeks. For
example it really bugs me that semaphore counts cannot be read from
proc. The only way I can think of getting that fixed is change to
kernel side.

One of the ways to solve the problem would be to add fields
to/proc/sysvipc/sem but that would change ABI. Perhaps making msg sem
& shm directories to proc containing subdirectories that are named
after object id is way to go. Much like how processes are represented.
That would make IPC info easy to extend ever needed, and quite
intuitive to use. But before writing that sort of change I think it's
good idea to ask advice from kernel developers. Looking git log[1] it
seems Al Viro might have opinion whether to add field or to do greater
change.

[1] git shortlog --no-merges -sne v3.0..HEAD ipc

>  but I guess that it's pretty obvious from already applied patches how
>  should be implemented the rest.

I will investigate...

>  Changes:
>
>     - created sys-utils/ipcutils.{c,h}
>     - renamed functions
>     - replaced all 'unsigned long' and 'size_t' with uint64_t
>
>      The reason why we want to read from /proc is to be robust on
>      systems where kernel is 64bit and userspace is 32bit. You cannot
>      use long or size_t for data from /sys or /proc...

...and adapt to correct behavior. Thank you for review and examples.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
