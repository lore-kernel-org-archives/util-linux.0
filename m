Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:35998 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdL2Sh7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 29 Dec 2017 13:37:59 -0500
Date: Fri, 29 Dec 2017 13:37:54 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Karel Zak <kzak@redhat.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        util-linux@vger.kernel.org,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <rain@vojtechvladyka.cz>
Subject: Re: fsck command line API
Message-ID: <20171229183754.GC11757@thunk.org>
References: <20171227101429.bisgfv5wumxcqiqp@pali>
 <20171229120242.lnp7dsp5wuyqrasr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229120242.lnp7dsp5wuyqrasr@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 29, 2017 at 01:02:42PM +0100, Karel Zak wrote:
> > Are there already defined some set of command line arguments which are
> > expected for fsck tools? Or exit status values from those tools?
> 
> We have no API. The solution is to call fsck wrapper with proper
> command line.
> 
>     fsck [options] [--] [fs-specific-options]
> 
> The exit code returned when multiple filesystems are checked is the
> bit-wise OR of the exit codes for each filesystem that is checked. The
> man page contains some return codes. It's probably good idea to use
> the same codes in the fs specific fsck tools.

Well *fsck* may not have an API.  But the init scripts or systemd unit
files do have some common expectations.  In general fsck -a or -p will
be used the boot scripts, and that means "automatic" or "preen".  The
-a and -p option should do the same thing, and it's the sort of
automatic, "safe" fixups that can be done in an unattended setup, such
as during the boot.

If there is a file system inconsistency that can not been fixed, then
fsck should exit with the exit status of 4.  From the fsck man page:

       The exit code returned by fsck is the sum of the following
       conditions:

              0      No errors
              1      Filesystem errors corrected
              2      System should be rebooted
              4      Filesystem errors left uncorrected
              8      Operational error
              16     Usage or syntax error
              32     Checking canceled by user request
              128    Shared-library error

       The exit code returned when multiple filesystems are checked is
       the bit-wise OR of the exit codes for each filesystem that is
       checked.

An exit status of 2 means that the file system should be rebooted.
This is typically combined with 1 because this tends to happen when
the root file system has been modified, and so the kernel may have
incorrect file system state cached from using the root file system to
run fsck.  So fsck.extN will check to see if it is the root file
system being checked, and if it is, and changes were made to the file
system, then it will exit with a status code of 3.  If changes were
made to the file system and it is not the root file system, then it
will return with an exit code of 1.  This is not an error; just an
informative signal that changes were made by fsck.extN.  If no changes
were necessary, fsck.extN will return with an exit code of 0.

The other exit codes can be used if they are applicable; if the user
aborts an fsck run with ^C, then fsck.extN will return an exit status
code of 32.  If the command line has options which are not recognized
fsck.extN will return 16.  And so on.


The other commonly used conventions is that the -y option means to
just blindly fix all errors, regardless of whether it might be safe or
whether in the hands of a skilled sysadmin, some data loss might be
avoidable if the file system specific fsck is run manually, perhaps in
conjuction with low-level debugging tools (e.g., such as debugfs for
ext2/3/4 or xfs_db for xfs, etc.)

Some init scripts will use -y because they know that there is no
skilled operator around.  For example, in an mobile handset or an IOT
device, maybe fsck -y will be used because if the file system is
corrupted because of a power drop interacting with crappy (sorry,
"cost optimized") flash, all you can do use fsck -y and pray.

Also -n is used to not fix any errors at all (-y means "all yes", -n
means "all no").  This is used with the exit status codes for scripts
that are trying to check the consistency of a file system without
actually doing anything.

Typically, if no arguments are given, then the fsck will operate in
interactive mode, where it will report each inconsistency, and then
ask the user if she would like to fix the inconsistency or not.

Regards,

						- Ted
