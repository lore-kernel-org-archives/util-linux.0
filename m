Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26246 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933583AbaH0Nls (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Aug 2014 09:41:48 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7RDfmvP010461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 27 Aug 2014 09:41:48 -0400
Received: from x2.net.home (vpn1-7-220.ams2.redhat.com [10.36.7.220])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7RDflLZ030975
	for <util-linux@vger.kernel.org>; Wed, 27 Aug 2014 09:41:48 -0400
Date: Wed, 27 Aug 2014 15:41:47 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.25.1-rc1
Message-ID: <20140827134147.GE30359@x2.net.home>
References: <20140827133354.GC30359@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140827133354.GC30359@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 27, 2014 at 03:33:54PM +0200, Karel Zak wrote:
> 
>  The util-linux release v2.25.1-rc1 is available at
> 
>     ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.25/
> 

 ...and release notes:


Util-linux 2.25.1 Release Notes
===============================

build-sys:
   - fix double prefix with explict --libdir  [Christoph Junghans]
   - fix switch_root/pivot_root cut-n-paste error in configure.ac  [Andreas Henriksson]
cfdisk:
   - fix typo in the previous commit  [Karel Zak]
   - reenable cursor when quitting  [Karel Zak]
   - wrong interpretation of yes in non-english language  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
fdisk:
   - always print warning for mis-aligned partitions  [Karel Zak]
   - fix -l [<device>]  [Karel Zak]
   - update tests and clean up output  [Karel Zak]
hexdump:
   - Fix parse format of "byte count without repetition count"  [HUANG Wei]
hwclock:
   - check for permissions before use clock interface  [Karel Zak]
   - use pluralized translations.  [Lauri Nurmi]
libblkid:
   - (gpt) fix PT offset  [Karel Zak]
   - (gpt) use real sector size to set PTMAGIC_OFFSET  [Karel Zak]
libfdisk:
   - (dos) fix logical partitions add/delete code  [Karel Zak]
   - (gpt) add Microsoft Storage Spaces GUID  [Sergei Antonov]
   - (gpt) allow to specify attr bit by API  [Karel Zak]
libmount:
   - use -t for type.subtype in helpers API  [Karel Zak]
lscpu:
   - clean up vmware inline asm  [Mike Frysinger]
mcookie:
   - avoid format warning  [Bernhard Voelker]
more:
   - replace ad-hoc support for plurals with gettext plurals.  [Lauri Nurmi]
po:
   - merge changes  [Karel Zak]
   - update cs.po (from translationproject.org)  [Petr Písař]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update zh_CN.po (from translationproject.org)  [Wylmer Wang]
sfdisk:
   - use pluralized translation.  [Lauri Nurmi]
swapon:
   - remove invalid error string print outs  [Sami Kerola]
tests:
   - Fall back on host/getent in ts_resolve_host  [Andreas Henriksson]
   - allow non-inotify tailf to keep up  [Andreas Henriksson]
   - apply travis clang PATH workaround  [Sami Kerola]
   - fix fdisk/bsd for the two possible sectors/offsets  [Aurelien Jarno]
   - kill output message change  [Sami Kerola]
   - make ipcs limit calculations work when numbers are large  [Sami Kerola]
textual:
   - fix some typos and inconsistencies in various messages  [Benno Schulenberg]
   - remove some inconsistent periods from error messages  [Benno Schulenberg]
various:
   - erase all traces of the long-obsolete xiafs  [Benno Schulenberg]
