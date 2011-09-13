Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39781 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801Ab1IMVVh convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Sep 2011 17:21:37 -0400
Received: by qyk30 with SMTP id 30so3121321qyk.19
        for <util-linux@vger.kernel.org>; Tue, 13 Sep 2011 14:21:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Tue, 13 Sep 2011 23:13:57 +0200
Message-ID: <CAG27Bk342RY_dMN5BFW9G+9z-KmmasX0XOA4UVSrn+tSsvmVRA@mail.gmail.com>
Subject: [pull] some sys-utils improvements
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I started to look sys-utils directory, and got obsessed by getting ipc
stuff to behave like a tool from this millennium. The whole directory
is not done, but I feel this is already big enough patch set.

I must admit that there is a lurking bug. When ipcrm tries to delete
everything, new --all switch without options, it prints fail rubbish
when there are only message queues resources. Bellow is an example how
I could see the issue.

$ ./ipcs

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status

------ Semaphore Arrays --------
key        semid      owner      perms      nsems

------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages

$ ./ipcmk -Q
Message queue id: 14581760
$ ./ipcrm --all -v
removing message queue id `14581760'
ipcrm: invalid id (14581760)

Strange enough the `invalid id' is not reported if I comment out
either shared memory or semaphore if blocks from remove all function.
And same happens when remove all explicitly specifies message queue
resource.

$ ./ipcmk -Q
Message queue id: 14614528
$ ./ipcrm --all=msg -v
removing message queue id `14614528'

I am 99.9% certainty my code is wrong, I just don't see how and advice
is very welcome. Other than this the patch set should be fairly OKish.

p.s. Persons who do not want to fetch my git branch, but are
interested to check what might be problem, here is the file:
https://raw.github.com/kerolasa/lelux-utiliteetit/sys-utils/sys-utils/ipcrm.c

--- snip
The following changes since commit 4e9b3bfda20ebbaf5d925dedad6ce8e2b678b563:

  lib,cpuset: fix compiler warning [-Wuninitialized] (2011-09-10 00:02:00 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit sys-utils

Sami Kerola (26):
      setarch: move options struct to function scope
      setarch: use program_invocation_short_name
      setarch: add version printing
      ipcmk: add long options & fix usage()
      ipcmk: remove useless code
      ipcmk: validate numeric option arguments
      ipcmk: remove camel casing
      ipcmk: include-what-you-use header check
      ipcrm: add long options
      ipcrm: exit if unknown error occurs
      ipcrm: refactor new and old main to share code
      ipcrm: include-what-you-use header check
      ipcs: add long options
      ipcs: include-what-you-use header check
      ipcs: comment & white space clean up
      pivot_root: add version & help option
      docs: mention long options in pivot_root.8
      ctrlaltdel: add version & help options
      docs: mention long options in ctrlaltdel.8
      docs: add --version to setarch.8
      docs: add long options to ipcmk.1 man page
      docs: add long options to ipcrm.1 man page
      docs: add long options to ipcs.1 man page
      ipcrm: add --all option
      ipcmk: allow high speed ipc creation
      ipcrm: add --verbose option

 sys-utils/Makefile.am  |    1 +
 sys-utils/ctrlaltdel.8 |   20 ++-
 sys-utils/ctrlaltdel.c |   39 ++++-
 sys-utils/ipcmk.1      |   52 +++---
 sys-utils/ipcmk.c      |  144 +++++++--------
 sys-utils/ipcrm.1      |   61 +++----
 sys-utils/ipcrm.c      |  491 ++++++++++++++++++++++++++++++------------------
 sys-utils/ipcs.1       |  101 ++++++----
 sys-utils/ipcs.c       |  279 ++++++++++++++-------------
 sys-utils/pivot_root.8 |    9 +-
 sys-utils/pivot_root.c |   60 +++++-
 sys-utils/setarch.8    |   21 ++-
 sys-utils/setarch.c    |   74 ++++----
 13 files changed, 788 insertions(+), 564 deletions(-)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
