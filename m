Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20121107100132.GA29631@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
	<20121105164251.GA3799@x2.net.home>
	<CAG27Bk2ZbPH+Zfbt0vR_GLyLuZoy7QHv-b96WtpEFm963DpD9w@mail.gmail.com>
	<20121107100132.GA29631@x2.net.home>
Date: Sun, 11 Nov 2012 23:01:11 +0000
Message-ID: <CAG27Bk3JCOM1cbkrh_JxiFv1WzQNAAi4no8iTPbX8ALSwTfjLQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] make ipcs to use proc
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 7, 2012 at 10:01 AM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Nov 07, 2012 at 09:40:16AM +0000, Sami Kerola wrote:
>> On Mon, Nov 5, 2012 at 4:42 PM, Karel Zak <kzak@redhat.com> wrote:
>> >  I have created ipc branch at hithub and applied some of the patches
>> >  (unfortunately with many changes).

Hi Karel, and others,

Yes, I had a look of the changes and there were quite some indeed, but
they made the command much better. Thank you for that.

>> One of the ways to solve the problem would be to add fields
>> to/proc/sysvipc/sem but that would change ABI. Perhaps making msg sem
>> & shm directories to proc containing subdirectories that are named
>> after object id is way to go. Much like how processes are represented.
>> That would make IPC info easy to extend ever needed, and quite
>> intuitive to use. But before writing that sort of change I think it's
>> good idea to ask advice from kernel developers. Looking git log[1] it
>> seems Al Viro might have opinion whether to add field or to do greater
>> change.
>
>  Well, we don't have to real all from /proc. I think it's fine to read
>  some problematic variables (shm sizes) from /proc to keep it
>  32/64-bit independent, but the rest we can read by regular
>  {sem,msg,shm}ctl() syscalls.
>
>  I guess you can mix /proc and {sem,msg,shm}ctl() in many cases
>  (especially if there is no enough information in /proc).

While modernizing the rest of the functions I noticed message queues
are also missing single value in proc. See the second last print_msg
for details. I think /proc could be more complete. Let see what kernel
maintainers think.

>  I think many problems has been already fixed by ipc_shm_ wrappers.

As usual you are right. The last remaining issue I want to fix in ipcs
is return values. Some of the functions fail, and return void, while
they should tell user as command return value that things did not go
brilliantly. Meanwhile here is the latest.

The following changes since commit c13d60b291cfe3e2c094225195d967c9f195ca54:

  agetty: fix autodetection for TERM (2012-11-02 12:38:25 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git ipc

for you to fetch changes up to e8bc655429c1c0642b1956cf796b424af6e3043e:

  ipcs: remove print_perms() (2012-11-11 22:41:24 +0000)

----------------------------------------------------------------
Karel Zak (5):
      libblkid: keep header buffer unmodified after failed CRC check.
      lib/path: rename functions to be more explicit
      lib/path: add path_read_u64()
      ipcs: clean up do_shm()
      ipcs: fix ipc_shm_get_info(), use calloc

Sami Kerola (9):
      ipcs: add /proc and /sys path definitions
      ipcs: determine ipc limits from /proc
      ipcs: read shared memory values from /proc
      ipcs: make individual shared memory id printing to use /proc
      ipcs: clean up do_sem(), and add ipc_sem_get_info()
      ipcs: make individual semaphore id printing to use /proc
      ipcs: clean up do_msg(), and add ipc_msg_get_info()
      ipcs: make individual message queue id printing to use /proc
      ipcs: remove print_perms()

 include/path.h                |  18 +-
 include/pathnames.h           |  12 +
 lib/path.c                    |  40 ++-
 libblkid/src/partitions/gpt.c |   8 +-
 sys-utils/Makemodule.am       |   6 +-
 sys-utils/chcpu.c             |  22 +-
 sys-utils/ipcs.c              | 577 ++++++++++++++++++------------------------
 sys-utils/ipcutils.c          | 466 ++++++++++++++++++++++++++++++++++
 sys-utils/ipcutils.h          | 170 +++++++++++++
 sys-utils/lscpu.c             |  30 +--
 10 files changed, 972 insertions(+), 377 deletions(-)
 create mode 100644 sys-utils/ipcutils.c
 create mode 100644 sys-utils/ipcutils.h

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
