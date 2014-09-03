Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbaICKye (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Sep 2014 06:54:34 -0400
Date: Wed, 3 Sep 2014 12:54:27 +0200
From: Karel Zak <kzak@redhat.com>
To: inux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.25.1
Message-ID: <20140903105427.GH21325@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The util-linux stable release v2.25.1 is available at

    ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.25

Feedback and bug reports, as always, are welcomed.

  Karel


Util-linux 2.25.1 Release Notes
===============================

build-sys:
   - create parent directory for $(PATHFILES)  [Michael Marineau]
   - fix double prefix with explict --libdir  [Christoph Junghans]
   - fix switch_root/pivot_root cut-n-paste error in configure.ac  [Andreas Henriksson]
   - release++ (v2.25.1-rc1)  [Karel Zak]
cfdisk:
   - fix typo in the previous commit  [Karel Zak]
   - reenable cursor when quitting  [Karel Zak]
   - wrong interpretation of yes in non-english language  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
   - update v2.25.1-ReleaseNotes  [Karel Zak]
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
   - update da.po (from translationproject.org)  [Joe Hansen]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update fr.po (from translationproject.org)  [David Prévot]
   - update nl.po (from translationproject.org)  [Benno Schulenberg]
   - update pl.po (from translationproject.org)  [Jakub Bogusz]
   - update pt_BR.po (from translationproject.org)  [Rafael Ferreira]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
   - update vi.po (from translationproject.org)  [Trần Ngọc Quân]
   - update zh_CN.po (from translationproject.org)  [Wylmer Wang]
   - update zh_TW.po (from translationproject.org)  [Wei-Lun Chao]
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

- erase all traces of the long-obsolete xiafs  [Benno Schulenberg]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
