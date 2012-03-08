Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab2CHJRH (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 8 Mar 2012 04:17:07 -0500
Date: Thu, 8 Mar 2012 10:17:02 +0100
From: Karel Zak <kzak@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: Dealing with overly verbose fsck output
Message-ID: <20120308091702.GB28628@x2.net.home>
References: <E1S5Nyx-0003tY-M1@tytso-glaptop.cam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1S5Nyx-0003tY-M1@tytso-glaptop.cam.corp.google.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Ted,

On Wed, Mar 07, 2012 at 04:01:11PM -0500, Theodore Ts'o wrote:
> I've recently come accross an interesting problem which is caused by a
> file system corruption which causes e2fsck to emit a huge amount of
> detail.  The verobosity is useful in some cases for debugging things, so
> I don't want to eliminate the output.  However, I'd like to squelch the
> output being sent to the console if it exceeds some limit, because if
> the system has a serial console attached, this can slow down the boot
> sequence such that a watchdog timer that detects if the system hasn't
> completed its boot sequence in a reasonable amount of time can kick in
> and kill off the machine.  I'd still like the e2fsck log output to get
> saved to a file, however.
> 
> Would patches that extended Frank Mayhar's work so that we can set some
> threshold after which the console gets a "output squelched; see log file
> XXXX for the rest" be something you'd be receptive to?   I think this is
> a situation that is generally applicable to more than just at Google ---
> lots of enterprise customers use serial consoles, and will run into the
> same annoyance --- but if you think this is adding too much complexity
> into fsck, I'll understand...

I'm just working on Frank's patches, my temporary branch for this task
is at:

  https://github.com/karelzak/util-linux/commits/fsck

I have merged the first patch 

  fsck: Add a -r option to report memory and runtime statistics

with some minor changes:

  - report all on one line
  - use "real" rather than "elapsed"

so the stats output looks like:

/dev/sda1: status 0, rss 92828, real 4.002804, user 2.677592, sys 0.86186


The next Frank's patches are more controversial due to complexity :-)
Anyway, I believe that we can find a compromise. I'd like to avoid
hardcoded paths and paths management (search for "completion"
scripts) in fsck. My suggestion is to move all to command line. For
example:

  fsck -A -L '/var/log/fsck-%device%'

where fsck will use the -L argument as a template for the log paths.

The "completion" scripts seems unnecessary if we will have usable
(parsable) logs with exactly defined format, then you can write a
simple logs parser and analyze the logs. The logs analyzer could be
executed from init scripts after fsck:

  TIMESTAMP=$(date '+%s')
  fsck -A -r -L /var/log/fsck-$(TIMESTAMP)-%device%

  for x in /var/log/fsck-$(TIMESTAMP)-*; do
    /bin/fsck-log-analyzer "$x"
  done

The log will contain all fsck output and some extra section with
parsable information, something like:

### fsck-summary
FSCK_DEVICE : <devname>
FSCK_FSTYPE : ext4
FSCK_STATUS : <return code>
...
###


 Comments? If you agree the I'll implement it.


> P.S.  Most unfortunately, Frank has had to go on medical leave, so he

 I know, Frank sent me email yesterday :-(

> asked me to take over getting his patches upstreamed.  If there are any
> changes you'd like me to make to the patches which he submitted, please
> let me know.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
