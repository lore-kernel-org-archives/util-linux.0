Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f171.google.com ([209.85.128.171]:55320 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdKIVVe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Nov 2017 16:21:34 -0500
Date: Thu, 9 Nov 2017 22:21:31 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171109212131.uxraxzwpvrlyfyys@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171105130608.5oww3b2fnnrwe7ok@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 05 November 2017 14:06:08 Pali Rohár wrote:
> On Wednesday 11 October 2017 23:24:35 Pali Rohár wrote:
> > On Wednesday 04 October 2017 17:33:32 Pali Rohár wrote:
> > > Hi! There is a big inconsistency in Linux tools which read or write
> > > FAT32 label in filesystem images. The most common used are tools:
> > > blkid (from util-linux project), fatlabel (previously known as
> > > dosfslabel; from dosfstools project) and mlabel (from mtools project).
> > > 
> > > FAT32 is itself a big mess from Microsoft hell and even FAT32
> > > implementation in Microsoft Windows systems is not compliant to the
> > > released FAT32 documentation from Microsoft.
> > > 
> > > In past months I observed that Linux FAT32 tools has its own way how
> > > they interpret FAT32 label (known as volume id) and because every GUI
> > > application uses one of those low-level command line tool, it is a big
> > > mess if one application say that FAT32 label is A and another that it is
> > > B. And then Windows XP say, it is C.
> > > 
> > > I would like to open discussion if it would be possible to change
> > > behavior how blkid (from util-linux project) and fatlabel (from
> > > dosfstool project) handle FAT32 label. Ideally to report exactly same
> > > output.
> > > 
> > > Basic information about FAT32 label:
> > > 
> > > 1) It is stored in two locations: boot sector and root directory as
> > >    file name.
> > > 
> > > 2) In both location format is 11 bytes, padded with spaces (not nulls).
> > > 
> > > 3) Empty label in boot sector is stored as "NO NAME    " and not as
> > >    empty string.
> > > 
> > > 4) Empty label in root directory is stored either as name which starts
> > >    with byte 0xE5, or is not stored in root directory at all.
> > > 
> > > 5) If label contains leading byte 0xE5, then in root directory is stored
> > >    as byte 0x05.
> > > 
> > > 6) Label string is stored according to current DOS code page. Therefore
> > >    label string needs to be converted to bytes.
> > > 
> > > 7) Label string cannot contain control characters and characters from
> > >    the set   ? / \ | . , ; : + = [ ] < > "   plus lower case characters
> > >    are stored as their upper case variant (not only ASCII).
> > > 
> > > (Please correct me if I'm wrong in some of those points)
> > > 
> > > Plus Microsoft Windows systems fully ignores label stored in boot
> > > sector. Seems they do not read it nor they do not update it on changes.
> > > 
> > > Looks like that mlabel (from mtools) applies all above rules and uses
> > > DOS code page 850 by default (can be changed in config file).
> > > 
> > > blkid and fatlabel process special cases from 1) to 5) differently and
> > > they operates on raw bytes, not strings (in DOS code page).
> > > 
> > > mlabel reads label from the root directory (missing entry is interpreted
> > > as no label; there is no fallback to boot sector), but "set" operation
> > > modify label in both location boot sector + root directory. Basically it
> > > is near to Windows implementation. And reason why Gparted GUI
> > > application uses mlabel and not fatlabel.
> > > 
> > > As Linux does not have "current DOS code page" and argv arguments are
> > > not (Unicode) strings, but arbitrary bytes, I understand that for point
> > > 6) it is easier to operates not on FAT strings (in current code page),
> > > but rather on bytes. Which also would be same on all machines with any
> > > configuration.
> > > 
> > > But would it be possible to decide and unify handling of point 2), 3),
> > > 4), 5)? Ideally with combination how to handle situation when different
> > > label is stored in boot sector and root directory.
> > > 
> > > As Windows does not use label in boot sector, it is very common
> > > situation that label in boot sector differs from the root directory.
> > > 
> > > The best would be see in all cases same label from blkid, fatlabel and
> > > mlabel. Ideally same as Windows machines -- but due to DOS code page,
> > > this is possible only for ASCII subset of the 8bit encoding. IIRC most
> > > (or all?) DOS code page has same characters in printable ASCII range.
> > > 
> > > It is really bad situation if I open disk in Gparted which show me label
> > > via mlabel and then I open in KDE Partition Manager and I see different
> > > label string (as it reads it from fatlabel).
> > > 
> > > Also note that older version of fatlabel (when it was named dosfslabel)
> > > operated only the label stored in boot sector (and label stored in root
> > > directory was not read or touched).
> > > 
> > 
> > Hi! I did some testing of FAT32 label with different tools and here are
> > results:
> 
> Hi! I did more tests with MS-DOS and Windows systems and I'm extending
> result tables below:
> 
> >                                                  dosfslabel 3.0.12   fatlabel 4.1       blkid 2.20.1   mlabel 4.0.12   label.exe Windows XP
> > fat32_mkdosfs_label1                             'label1     '       'label1     '      'label1'       'label1     '   'label1'
> > fat32_mkdosfs_label1_dosfslabel_empty            '           '       '           '      none           '           '   none
> > fat32_mkdosfs_label1_dosfslabel_label2           'label2     '       'label2     '      'label2'       'label2     '   'label2'
> > fat32_mkdosfs_label1_dosfslabel_NO_NAME          'NO NAME    '       'NO NAME    '      none           'NO NAME    '   'NO NAME'
> > fat32_mkdosfs_label1_mlabel_erase                'NO NAME    '       'NO NAME    '      none           none            none
> > fat32_mkdosfs_label1_mlabel_NO_NAME              'NO NAME    '       'NO NAME    '      none           'NO NAME    '   'NO NAME'
> > fat32_mkdosfs_label1_xp_erase                    'label1'    '       0xE5'abel1     '   'label1'       none            none
> > fat32_mkdosfs_label1_xp_label2                   'label1'    '       'LABEL2     '      'LABEL2'       'LABEL2     '   'LABEL2'
> > fat32_mkdosfs_none                               '           '       '           '      none           none            none
> > fat32_mkdosfs_none_dosfslabel_label1             'label1     '       'label1     '      'label1'       none            none
> > fat32_mkdosfs_none_dosfslabel_label1_xp_label2   'label1'    '       'LABEL2     '      'LABEL2'       'LABEL2     '   'LABEL2'
> > fat32_mkdosfs_none_dosfslabel_NO_NAME            'NO NAME    '       'NO NAME    '      none           none            none
> > fat32_mkdosfs_none_xp_label1                     '           '       'LABEL1     '      'LABEL1'       'LABEL1     '   'LABEL1'
> > fat32_mkdosfs_none_xp_label1_dosfslabel_label2   'label2     '       'label2     '      'label2'       'label2     '   'label2'
> > fat32_xp_label1                                  'NO NAME    '       'LABEL1     '      'LABEL1'       'LABEL1     '   'LABEL1'
> > fat32_xp_none                                    'NO NAME    '       'NO NAME    '      none           none            none
> > fat32_xp_none_dosfslabel_label1                  'label1     '       'label1     '      'label1'       none            none
> > fat32_xp_none_mlabel_label1                      'LABEL1     '       'LABEL1     '      'LABEL1'       'LABEL1     '   'LABEL1'
> 
>                                                    label.exe MS-DOS 7.10   label.exe Windows 98   label.exe Windows 10
> fat32_mkdosfs_label1                               'label1'                'label1'               'label1'
> fat32_mkdosfs_label1_dosfslabel_empty              ''                      ''                     none
> fat32_mkdosfs_label1_dosfslabel_label2             'label2'                'label2'               'label2'
> fat32_mkdosfs_label1_dosfslabel_NO_NAME            'NO NAME'               'NO NAME'              'NO NAME'
> fat32_mkdosfs_label1_mlabel_erase                  none                    none                   none
> fat32_mkdosfs_label1_mlabel_NO_NAME                'NO NAME'               'NO NAME'              'NO NAME'
> fat32_mkdosfs_label1_xp_erase                      none                    none                   none
> fat32_mkdosfs_label1_xp_label2                     'LABEL2'                'LABEL2'               'LABEL2'
> fat32_mkdosfs_none                                 none                    none                   none
> fat32_mkdosfs_none_dosfslabel_label1               none                    none                   none
> fat32_mkdosfs_none_dosfslabel_label1_xp_label2     'LABEL2'                'LABEL2'               'LABEL2'
> fat32_mkdosfs_none_dosfslabel_NO_NAME              none                    none                   none
> fat32_mkdosfs_none_xp_label1                       'LABEL1'                'LABEL1'               'LABEL1'
> fat32_mkdosfs_none_xp_label1_dosfslabel_label2     'label2'                'label2'               'label2'
> fat32_xp_label1                                    'LABEL1'                'LABEL1'               'LABEL1'
> fat32_xp_none                                      none                    none                   none
> fat32_xp_none_dosfslabel_label1                    none                    none                   none
> fat32_xp_none_mlabel_label1                        'LABEL1'                'LABEL1'               'LABEL1'
> 
> Seems that behavior of reading label from FAT32 volume is consistent
> between MS-DOS and different Windows versions. The only exception is
> when in label in the root directory is stored as empty string (11
> spaces). MS-DOS and Windows 98 treat it as label with empty string, but
> Windows XP and Windows 10 as disk without label.
> 
> > In the first column is image name (all images are compressed and
> > attached) which contains steps of operations, e.g. file name
> > fat32_mkdosfs_none_dosfslabel_label1_xp_label2 means:
> > 
> > 1. create filesystem with mkdosfs without specifying label
> > 2. change label with dosfslabel (3.0.12) to 'label1'
> > 3. change label under Windows XP to 'label2'
> > 
> > From testing it looks like that different tools and different version of
> > them have different behavior how they read or write FAT32 label, see
> > following table:
> > 
> >                              read boot   write boot   read root   write root
> > dosfslabel 3.0.0  - 3.0.6    YES         YES          NO          NO
> > dosfslabel 3.0.7  - 3.0.15   YES         YES          NO          BUGGY (YES - if already exists; NO - otherwise)
> > dosfslabel 3.0.16 - 4.1      YES         YES          YES         YES
> > label.exe Windows XP         NO          NO           YES         YES
> > blkid                        YES         NO           YES         NO
> > mlabel                       NO          YES          YES         YES
> 
> label.exe MS-DOS 6.22          NO          YES          YES         YES
> label.exe MS-DOS 7.10          NO          YES          YES         YES
> label.exe Windows 98 SE        NO          YES          YES         YES
> label.exe Windows 10           NO          NO           YES         YES
> 
> Older MS-DOS 6.22 does not support FAT32 disks, only FAT16. MS-DOS 7.10
> has support for FAT32 and also for LFN. But both tested MS-DOS versions
> and Windows 98 updates label in both locations: boot sector and root
> directory. Also in case when label is changed in Windows 98 via
> "My Computer" GUI.
> 
> From above tests it can be seen that both MS-DOS and all Windows
> versions ignores label which is stored in boot sector and show to user
> only label from root directory.
> 
> Also it can be seen that both MS-DOS versions do not have problems when
> label contains lower case letters.
> 
> > Attached images in compressed form has only 600 kB and I think they can
> > be useful for testing either blkid or dosfstools project, so I'm sending
> > them here.
> 

So from all tests and discussion I would propose new unification:

1. Read label only from the root directory. If label in root directory
   is missing then disk would be treated as without label. Label from
   boot sector would not be read.

   --> Reason: Windows XP and mlabel ignores what is written in boot
       sector. Windows XP even do not update boot sector, so label
       stored in boot sector is incorrect after any change done by
       Windows XP.

       This logic is used by all tested MS-DOS and Windows versions,
       plus also by mtools on Linux.

2. Write label to to both location, boot sector and root directory.

   --> Reason: MS-DOS 6.22, MS-DOS 7.10, Windows 98 and also mtools on
       Linux do this. This is also what is written in FAT specification.

       It also provides backward compatibility with old dosfslabel
       versions which read label only from boot sector.

2. Process 'NO NAME    ' label in root directory as 'NO NAME' name. Not
   as empty label.

   --> Reason: 'NO NAME    ' is regular entry in root directory and both
       Windows XP and mlabel handle it in this way.

3. Process 'NO NAME    ' label in boot directory as empty label. Not as
   label with name 'NO NAME'.

   --> Reason: On Windows XP when formatting empty disk and label is not
       specified then 'NO NAME    ' is stored to boot sector.

       Also in FAT specification is written that empty label is stored
       as 'NO NAME    '.

With this change we would get compatibility with MS-DOS, Windows (both
DOS-based and NT-based) and also with Linux mtools, modulo problems DOS
code page.

There are just two negatives:

1) Labels set by old dosfslabel versions (which stored them only to boot
   sector) would not be visible. But they are already not visible on
   MS-DOS or Windows machines, and also via mlabel (from mtools).

2) Behavior of blkid and fatlabel would be changed as both tools have
   different as proposed above, and based on tests they also differ each
   from other.

Andreas, Karel, what do you think about it?

-- 
Pali Rohár
pali.rohar@gmail.com
