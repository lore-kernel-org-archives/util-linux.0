Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f45.google.com ([74.125.82.45]:57336 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbdJDPdj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 4 Oct 2017 11:33:39 -0400
Date: Wed, 4 Oct 2017 17:33:32 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Linux & FAT32 label
Message-ID: <20171004153332.GA6696@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi! There is a big inconsistency in Linux tools which read or write
FAT32 label in filesystem images. The most common used are tools:
blkid (from util-linux project), fatlabel (previously known as
dosfslabel; from dosfstools project) and mlabel (from mtools project).

FAT32 is itself a big mess from Microsoft hell and even FAT32
implementation in Microsoft Windows systems is not compliant to the
released FAT32 documentation from Microsoft.

In past months I observed that Linux FAT32 tools has its own way how
they interpret FAT32 label (known as volume id) and because every GUI
application uses one of those low-level command line tool, it is a big
mess if one application say that FAT32 label is A and another that it is
B. And then Windows XP say, it is C.

I would like to open discussion if it would be possible to change
behavior how blkid (from util-linux project) and fatlabel (from
dosfstool project) handle FAT32 label. Ideally to report exactly same
output.

Basic information about FAT32 label:

1) It is stored in two locations: boot sector and root directory as
   file name.

2) In both location format is 11 bytes, padded with spaces (not nulls).

3) Empty label in boot sector is stored as "NO NAME    " and not as
   empty string.

4) Empty label in root directory is stored either as name which starts
   with byte 0xE5, or is not stored in root directory at all.

5) If label contains leading byte 0xE5, then in root directory is stored
   as byte 0x05.

6) Label string is stored according to current DOS code page. Therefore
   label string needs to be converted to bytes.

7) Label string cannot contain control characters and characters from
   the set   ? / \ | . , ; : + = [ ] < > "   plus lower case characters
   are stored as their upper case variant (not only ASCII).

(Please correct me if I'm wrong in some of those points)

Plus Microsoft Windows systems fully ignores label stored in boot
sector. Seems they do not read it nor they do not update it on changes.

Looks like that mlabel (from mtools) applies all above rules and uses
DOS code page 850 by default (can be changed in config file).

blkid and fatlabel process special cases from 1) to 5) differently and
they operates on raw bytes, not strings (in DOS code page).

mlabel reads label from the root directory (missing entry is interpreted
as no label; there is no fallback to boot sector), but "set" operation
modify label in both location boot sector + root directory. Basically it
is near to Windows implementation. And reason why Gparted GUI
application uses mlabel and not fatlabel.

As Linux does not have "current DOS code page" and argv arguments are
not (Unicode) strings, but arbitrary bytes, I understand that for point
6) it is easier to operates not on FAT strings (in current code page),
but rather on bytes. Which also would be same on all machines with any
configuration.

But would it be possible to decide and unify handling of point 2), 3),
4), 5)? Ideally with combination how to handle situation when different
label is stored in boot sector and root directory.

As Windows does not use label in boot sector, it is very common
situation that label in boot sector differs from the root directory.

The best would be see in all cases same label from blkid, fatlabel and
mlabel. Ideally same as Windows machines -- but due to DOS code page,
this is possible only for ASCII subset of the 8bit encoding. IIRC most
(or all?) DOS code page has same characters in printable ASCII range.

It is really bad situation if I open disk in Gparted which show me label
via mlabel and then I open in KDE Partition Manager and I see different
label string (as it reads it from fatlabel).

Also note that older version of fatlabel (when it was named dosfslabel)
operated only the label stored in boot sector (and label stored in root
directory was not read or touched).

-- 
Pali Rohár
pali.rohar@gmail.com
