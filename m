Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:43181 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800AbaDHVwk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 17:52:40 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id DF1F2AAF3
	for <util-linux@vger.kernel.org>; Tue,  8 Apr 2014 21:52:38 +0000 (UTC)
Message-ID: <1396993958.14732.144.camel@oct.suse.cz>
Subject: libblkid: check for ext* is deeply broken
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Tue, 08 Apr 2014 23:52:38 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I am digging into an incorrect detection of ext* filesystems in blkid
2.24.1.

The result of blkid is totally illogical. You cannot write any simple
function that will parse the result. Both prioritizing of TYPE over
SEC_TYPE and vice versa fail for some cases.

ext2 with ext4 module unloaded:
  SEC_TYPE="ext2" TYPE="ext4"
ext3 with ext4 module unloaded:
  SEC_TYPE="ext2" TYPE="ext3"
ext4 with ext4 module unloaded:
  TYPE="ext4"
ext2 with ext4 module loaded:
  TYPE="ext2"
ext3 with ext4 module loaded:
  SEC_TYPE="ext2" TYPE="ext3"
ext4 with ext4 module loaded:
  TYPE="ext4"

I even don't know, what was intended to be returned on system that
supports ext2 via ext4:
    SEC_TYPE="ext2" TYPE="ext4"
  or
    TYPE="ext2"?

If the first one, all system_supports_ext?() have to be rewritten to
detect loaded ext4 module supporting ext2.

If the second one, system_supports_ext4_ext2() should be moved inside
system_supports?() calls.

In both cases, expressions using these calls have to be rewritten.

Details:

It seems, that the code attempts to be intelligent and detect the best
possible support for the particular file system.

But check as they are written are broken, return inconsistent results
and cannot be fixed to be consistent:

check_for_modules("ext2") correctly returns that module named "ext2"
does not exist (only "ext4" does).

But at least on a new Linux kernel version I am working on
fs_proc_check("ext2") returns success whenever ext4 module is loaded.
It is because /proc/filesystems include "ext2", even if the module is
named "ext4".

It causes system_supports_ext?() being inconsistent between calls with
"ext4" module loaded and "ext4" module unloaded.

It implies, that all subsequent logic expressions in probe_ext* are
inconsistent and makes no sense as well. Additionally, I guess that some
of these checks are incorrect per self. (As long as only one
probe_ext?() returns success, then blkid returns at least something.)

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

