Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbdLNPAa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 14 Dec 2017 10:00:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60B0E5AFD9
        for <util-linux@vger.kernel.org>; Thu, 14 Dec 2017 15:00:30 +0000 (UTC)
Received: from ws.net.home (ovpn-117-230.ams2.redhat.com [10.36.117.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5636C52E
        for <util-linux@vger.kernel.org>; Thu, 14 Dec 2017 15:00:29 +0000 (UTC)
Date: Thu, 14 Dec 2017 16:00:26 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.31.1 plan
Message-ID: <20171214150026.7lk3mtwng5jbfcnf@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 I'd like to release stable maintenance v2.31.1 tomorrow or on Monday.

 All is already in stable/v2.31 branch:
 https://github.com/karelzak/util-linux/tree/stable/v2.31

 See log below, comments & objections?

 Note that some invasive bug fixes like libblkid UDF changes (Pali)
 or some date/time cleanups (jwp) are missing.

    Karel


bash-completion:
   - Exclude /dev/fd from fsck find  [Kevin Locke]
blkid:
   - Add support for LUKS2 and new LABEL attributes.  [Milan Broz]
blockdev:
   - be more explicit for BLKSSZ in blockdev.8  [Karel Zak]
build-sys:
   - move rfkill to /usr/sbin  [Karel Zak]
column:
   - use \x<hex> for invalid multibyte seq.  [Karel Zak]
dmesg:
   - add note about -F format to the man page  [Karel Zak]
docs:
   - improve setarch(8) manual page  [Sami Kerola]
fincore:
   - fix a typo in fincore.1  [Masatake YAMATO]
fsck.cramfs:
   - Fix bus error on broken file system.  [Tobias Stoeckmann]
hwclock:
   - add iso-8601 overflow check  [J William Piggott]
   - fix debug regression  [J William Piggott]
   - revert ioctl test  [Karel Zak]
lib/mbsalign:
   - add mbs_invalid_encode()  [Karel Zak]
lib/md5:
   - use ul_/UL_ prefix  [Karel Zak]
lib/sha1:
   - use ul_/UL_prefix for symbols  [Karel Zak]
lib/timeutils:
   - ISO_8601_BUFSIZ too small  [J William Piggott]
libblkid:
   - vfat  Fix reading labels which starts with byte 0x05  [Pali Rohár]
libfdisk:
   - (sun) enhance searching of free space  [Mikhail Vorobyov]
   - (sun) fix creation of whole disk partition  [Mikhail Vorobyov]
   - (sun) move aligning of the first sector before availability check  [Mikhail Vorobyov]
   - Fix uninitialized structure  [Roddy Shuler]
libmount:
   - Allow MNT_FORCE and MNT_DETACH at umount  [Joshua Watt]
   - add nsfs between pseudo filesystems  [Karel Zak]
libsmartcols:
   - don't add blank padding after left aligned title  [Karel Zak]
lsblk:
   - add hint about perms to man page  [Karel Zak]
lscpu:
   - Treat read failure on Xen Hypervisor properties as non-fatal  [Dirk Mueller]
lslocks:
   - add note about OFDLCK  [Karel Zak]
man:
   - use long options in text and add example to uuidgen  [Sami Kerola]
mcookie:
   - properly initialize hash  [Karel Zak]
md5:
   - declare byteReverse as static  [Luca Ceresoli]
misc:
   - fix typos  [Sami Kerola]
mount:
   - add hint about -t and root perms to the man page  [Karel Zak]
   - add more details about UUIDs and LABELs to the man page  [Karel Zak]
nsenter:
   - fix compiler warning [-Wuninitialized]  [Karel Zak]
rtcwake:
   - add note about HW and sleep to the man page  [Karel Zak]
   - fix sys vs. rtc time delta usage  [Karel Zak]
sample-scols-title:
   - add left title without padding  [Karel Zak]
sfdisk:
   - create empty label on 'write' command  [Karel Zak]
test_sha1:
   - update helper  [Karel Zak]
tests:
   - add LUKS test images  [Milan Broz]
   - add fsck.cramfs bad-header test  [Karel Zak]
   - update columns test due to dda229c7b2b16a31fae8e99079ab4f4ae5bc8eac  [Karel Zak]
   - update libsmartcols/title  [Karel Zak]
vipw:
   - do not let editor to inherit open file descriptors  [Sami Kerola]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
