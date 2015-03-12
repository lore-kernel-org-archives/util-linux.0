Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbbCLLWC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 07:22:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2CBM2cC016514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 07:22:02 -0400
Received: from ws ([10.40.204.58])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2CBM0Cu032553
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 07:22:01 -0400
Date: Thu, 12 Mar 2015 12:22:00 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.26.1 patches
Message-ID: <20150312112200.GB4637@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I'd like to release v2.26.1 as soon as possible (probably tomorrow :-)

All is ready in stable/v2.26 branch.
https://github.com/karelzak/util-linux/commits/stable/v2.26

Please, review, comment, etc.

The list of the patches proposed for the stable release also includes
some new logger(1) command line options. It's unusual for stable
release, but the changes are mostly result of refactoring and
regressions fixing and for better backward compatibility as well as
compatibility with RFCs and syslogs. I don't want to postpone such
changes for v2.27 and force people to use incompatible/broken version
from v2.26.

    Karel

 
Bill Pemberton (1):
      docs: fix some spelling errors and typos in man pages

Karel Zak (20):
      build-sys: add --disable-colors-default
      lib/colors: add USAGE_COLORS_DEFAULT
      sfdisk: add missing --color
      colors: cleanup man pages, add hint to usage()
      libfdisk: add {first,last}-lba header to sfdisk scritps
      agetty: support /usr/lib/os-release too
      logger: add comment
      logger: fix whitespace and compiler warning [-Wunused-variable]
      logger: remove "interface to syslog(3)" from man page
      logger: use username as the default tag
      agetty: make sure that reload file exists
      agetty: reload issue on --autologin --login-pause too
      logger: check for ntp_gettime() rather than for timex.h
      findmnt: don't rely on st_dev for --target
      libmount: cleanup fs root detection code
      logger: small change in usage()
      tests: update sfdisk --dump test
      libmount: add mnt_table_get_fs_root() to header file
      libmount: mark overlay as pseudo-FS
      cal: care about setuprterm() result

Peter Cordes (1):
      docs: fstab(5) grammar / English fixes, and some other updates

Rainer Gerhards (18):
      logger: fix invalid timestamp in rfc5425 format
      logger: fix inconsistent format regression when logging locally
      logger: fix invalid timestamp regression in local format
      logger: messages are logged with kern.* priority by default
      logger: fix -p kern.* priority is accepted regression
      logger: refactor the way output is written
      logger: bugfix: tcp syslog framing is broken, -T unusable
      logger man page: fix some "syslog(3) routine" remnants
      logger man page: bump man page date to current
      logger: permit to send messages larger than 1024 characters
      logger: refactor message generation
      logger: bugfix: missing sanity checks with --prio-prefix option
      logger man page: update --size doc
      logger: add --skip-empty to prevent logging empty lines
      silence compiler warning
      logger: fix multiple format bugs in rfc5424 formatter
      logger: add --msgid option, permits to set RFC5424 MSGID field
      logger man page: fix typo

Ruediger Meier (1):
      logger: link libsystemd-daemon.so

Sami Kerola (2):
      logger: move /dev/log to pathnames.h
      logger: fix -i argument parsing regression



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
