Return-Path: util-linux-owner@vger.kernel.org
Received: from dervish.wsisiz.edu.pl ([213.135.44.54]:51608 "EHLO
        dervish.wsisiz.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdBURy6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 21 Feb 2017 12:54:58 -0500
Subject: Re: label-id and sfdisk problem
To: Karel Zak <kzak@redhat.com>
References: <a1e37c78-0162-2c2a-813e-1b1abee27fcb@wit.edu.pl>
 <20170221164928.geha65vjytxjsed5@ws.net.home>
 <64bb45d8-dfe2-caf2-e451-2009302d0932@wit.edu.pl>
Cc: util-linux@vger.kernel.org, Lukasz Trabinski <lukasz@trabinski.net>
From: =?UTF-8?Q?Bart=c5=82omiej_Solarz-Nies=c5=82uchowski?=
        <Bartlomiej.Solarz-Niesluchowski@wit.edu.pl>
Message-ID: <c8176357-5ded-3cd2-f191-50b4f7078387@wit.edu.pl>
Date: Tue, 21 Feb 2017 18:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <64bb45d8-dfe2-caf2-e451-2009302d0932@wit.edu.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060107060107010208050006"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms060107060107010208050006
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

W dniu 2017-02-21 o 17:58, Bart=C5=82omiej Solarz-Nies=C5=82uchowski pisz=
e:
DEBUG:
root@sysresccd /mnt % export SFDISK_DEBUG=3Dall
root@sysresccd /mnt % sfdisk /dev/sdb < henwar.2017.sdb.sfdisk
Checking that no-one is using this disk right now ... OK

Disk /dev/sdb: 489.1 GiB, 525112713216 bytes, 1025610768 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x5669b38d

Old situation:

Device     Boot   Start        End    Sectors   Size Id Type
/dev/sdb1  *       2048    1026047    1024000   500M  c W95 FAT32 (LBA)
/dev/sdb2       1026048 1025607679 1024581632 488.6G  7 HPFS/NTFS/exFAT

15530: sfdisk:    PARSE: <---next-line--->
 >>> Script header accepted.
15530: sfdisk:    PARSE: <---next-line--->
 >>> Script header accepted.
15530: sfdisk:    PARSE: <---next-line--->
 >>> Script header accepted.
15530: sfdisk:    PARSE: <---next-line--->
 >>> Script header accepted.
15530: sfdisk:    PARSE: <---next-line--->
 >>> Created a new DOS disklabel with disk identifier 0xd1b2a761.
Created a new partition 1 of type 'W95 FAT32 (LBA)' and of size 500 MiB.
15530: sfdisk:    PARSE: <---next-line--->
/dev/sdb2: Created a new partition 2 of type 'HPFS/NTFS/exFAT' and of=20
size 488.6 GiB.
15530: sfdisk:    PARSE: <---next-line--->
/dev/sdb3:
New situation:

Device     Boot   Start        End    Sectors   Size Id Type
/dev/sdb1  *       2048    1026047    1024000   500M  c W95 FAT32 (LBA)
/dev/sdb2       1026048 1025607679 1024581632 488.6G  7 HPFS/NTFS/exFAT

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
15530: sfdisk:     MISC: bye! [rc=3D0]

DEBUG2:
15774: libfdisk:     INIT: library debug mask: 0xffff
Available "LIBFDISK_DEBUG=3D<name>[,...]|<mask>" debug masks:
    all      [0xffff] : info about all subsystems
    ask      [0x0010] : fdisk dialogs
    help     [0x0001] : this help
    cxt      [0x0004] : library context (handler)
    label    [0x0008] : disk label utils
    part     [0x0040] : partition utils
    parttype [0x0080] : partition type utils
    script   [0x0200] : sfdisk-like scripts
    tab      [0x0100] : table utils
15774: libfdisk:      CXT: [0x8e2f338]: alloc
15774: libfdisk:      CXT: [0x8e2f338]: assigning device /dev/sdb
15774: libfdisk:      CXT: [0x8e2f338]: *** resetting context
15774: libfdisk:      CXT: [0x8e2f338]: /dev/sdb: discovering topology...=

15774: libfdisk:      CXT: [0x8e2f338]: initialize libblkid prober
15774: libfdisk:      CXT: [0x8e2f338]: result: log/phy sector size: 512/=
512
15774: libfdisk:      CXT: [0x8e2f338]: result: fdisk/optimal/minimal=20
io: 512/0/512
15774: libfdisk:      CXT: [0x8e2f338]: /dev/sdb: discovering geometry...=

15774: libfdisk:      CXT: [0x8e2f338]: total sectors: 1025610768=20
(ioctl=3D1025610768)
15774: libfdisk:      CXT: [0x8e2f338]: result: C/H/S: 63841/255/63
15774: libfdisk:      CXT: [0x8e2f338]: initialize in-memory first=20
sector buffer [sector_size=3D512]
15774: libfdisk:      CXT: [0x8e2f338]: reading: offset=3D0, size=3D512
15774: libfdisk:      CXT: [0x8e2f338]: probing for gpt
15774: libfdisk:    LABEL: GPT probe failed
15774: libfdisk:      CXT: [0x8e2f338]: probing for dos
15774: libfdisk:    LABEL: DOS: initialize, first sector buffer 0x8e31cd8=

15774: libfdisk:    LABEL: DOS PT geometry: heads=3D0, sectors=3D0
15774: libfdisk:      CXT: [0x8e2f338]: --> switching context to dos!
15774: libfdisk:      CXT: [0x8e2f338]: appling user device properties
15774: libfdisk:      CXT: [0x8e2f338]: reseting alignment...
15774: libfdisk:      CXT: [0x8e2f338]: alignment reseted to: first=20
LBA=3D2048, last LBA=3D1025610767, grain=3D1048576 [rc=3D0]
15774: libfdisk:      CXT: [0x8e2f338]: new C/H/S: 63841/255/63
15774: libfdisk:      CXT: [0x8e2f338]: new log/phy sector size: 512/512
15774: libfdisk:      CXT: [0x8e2f338]: initialized for /dev/sdb=20
[READ-WRITE]
15774: libfdisk:   SCRIPT: [0x8e31ee0]: alloc
15774: libfdisk:      TAB: [0x8e2f0d8]: alloc
15774: libfdisk:      CXT: [0x8e2f338]: setting reference to script=20
0x8e31ee0
15774: libfdisk:      ASK: [0x8e31f78]: alloc
15774: libfdisk:      ASK: [0x8e31f78]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31f78]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31f78]: reset
15774: libfdisk:      ASK: [0x8e31f78]: free
15774: libfdisk:      ASK: [0x8e31f10]: alloc
15774: libfdisk:      ASK: [0x8e31f10]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31f10]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31f10]: reset
15774: libfdisk:      ASK: [0x8e31f10]: free
15774: libfdisk:      ASK: [0x8e31fa8]: alloc
15774: libfdisk:      ASK: [0x8e31fa8]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31fa8]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31fa8]: reset
15774: libfdisk:      ASK: [0x8e31fa8]: free
15774: libfdisk:      ASK: [0x8e31fb8]: alloc
15774: libfdisk:      ASK: [0x8e31fb8]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31fb8]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31fb8]: reset
15774: libfdisk:      ASK: [0x8e31fb8]: free
15774: libfdisk:      ASK: [0x8e31f10]: alloc
15774: libfdisk:      ASK: [0x8e31f10]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31f10]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31f10]: reset
15774: libfdisk:      ASK: [0x8e31f10]: free
15774: libfdisk:      CXT: [0x8e2f338]: asking for disk dos ID
15774: libfdisk:      CXT: [0x8e2f338]: asking for disk dos item 0
15774: libfdisk:      ASK: [0x8e31f10]: alloc
15774: libfdisk:      ASK: [0x8e31f10]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31f10]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31f10]: reset
15774: libfdisk:      ASK: [0x8e31f10]: free
15774: libfdisk:      ASK: [0x8e31f10]: alloc
15774: libfdisk:      ASK: [0x8e31f10]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e31f10]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e31f10]: reset
15774: libfdisk:      ASK: [0x8e31f10]: free
15774: libfdisk:      CXT: [0x8e2f338]:  -- get table --
15774: libfdisk:      TAB: [0x8e2f150]: alloc
15774: libfdisk:     PART: [0x8e31f98]: alloc
15774: libfdisk:      TAB: [0x8e2f150]: add entry 0x8e31f98 [start=3D2048=
,=20
end=3D1026047, size=3D1024000,   primary]
15774: libfdisk:     PART: [0x8e32038]: alloc
15774: libfdisk:      TAB: [0x8e2f150]: add entry 0x8e32038=20
[start=3D1026048, end=3D1025607679, size=3D1024581632,   primary]
15774: libfdisk:      ASK: [0x8e327b8]: alloc
15774: libfdisk:      ASK: [0x8e327b8]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e327b8]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e327b8]: reset
15774: libfdisk:      ASK: [0x8e327b8]: free
15774: libfdisk:      TAB: [0x8e2f150]: wrong older check
15774: libfdisk:      TAB: [0x8e2f150]: reset
15774: libfdisk:      TAB: [0x8e2f150]: remove entry 0x8e31f98
15774: libfdisk:     PART: [0x8e31f98]: reset
15774: libfdisk:     PART: [0x8e31f98]: free
15774: libfdisk:      TAB: [0x8e2f150]: remove entry 0x8e32038
15774: libfdisk:     PART: [0x8e32038]: reset
15774: libfdisk:     PART: [0x8e32038]: free
15774: libfdisk:      TAB: [0x8e2f150]: free
15774: libfdisk:   SCRIPT: [0x8e31ee0]: setting new header label=3D'dos'
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 0
15774: libfdisk:   SCRIPT: [0x8e31ee0]:   parsing buffer
15774: libfdisk:   SCRIPT: [0x8e31ee0]:    parse header 'label: dos'
15774: libfdisk:   SCRIPT: [0x8e31ee0]: update 'label' header 'dos' -> 'd=
os'
15774: libfdisk:      ASK: [0x8e32380]: alloc
15774: libfdisk:      ASK: [0x8e32380]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32380]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32380]: reset
15774: libfdisk:      ASK: [0x8e32380]: free
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 1
15774: libfdisk:   SCRIPT: [0x8e31ee0]:   parsing buffer
15774: libfdisk:   SCRIPT: [0x8e31ee0]:    parse header 'label-id:=20
0x908b462c'
15774: libfdisk:   SCRIPT: [0x8e31ee0]: setting new header=20
label-id=3D'0x908b462c'
15774: libfdisk:      ASK: [0x8e32470]: alloc
15774: libfdisk:      ASK: [0x8e32470]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32470]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32470]: reset
15774: libfdisk:      ASK: [0x8e32470]: free
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 2
15774: libfdisk:   SCRIPT: [0x8e31ee0]:   parsing buffer
15774: libfdisk:   SCRIPT: [0x8e31ee0]:    parse header 'device: /dev/sdb=
'
15774: libfdisk:   SCRIPT: [0x8e31ee0]: setting new header device=3D'/dev=
/sdb'
15774: libfdisk:      ASK: [0x8e32308]: alloc
15774: libfdisk:      ASK: [0x8e32308]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32308]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32308]: reset
15774: libfdisk:      ASK: [0x8e32308]: free
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 3
15774: libfdisk:   SCRIPT: [0x8e31ee0]:   parsing buffer
15774: libfdisk:   SCRIPT: [0x8e31ee0]:    parse header 'unit: sectors'
15774: libfdisk:   SCRIPT: [0x8e31ee0]: setting new header unit=3D'sector=
s'
15774: libfdisk:      ASK: [0x8e32398]: alloc
15774: libfdisk:      ASK: [0x8e32398]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32398]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32398]: reset
15774: libfdisk:      ASK: [0x8e32398]: free
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 4
15774: libfdisk:   SCRIPT: [0x8e31ee0]:   parsing buffer
15774: libfdisk:   SCRIPT: [0x8e31ee0]:    parse script line: '/dev/sdb1 =

: start=3D        2048, size=3D     1024000, type=3Dc, bootable'
15774: libfdisk:     PART: [0x8e31f98]: alloc
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' start=3D 2048,=20
size=3D     1024000, type=3Dc, bootable'
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' size=3D 1024000,=20
type=3Dc, bootable'
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' type=3Dc, bootable'
15774: libfdisk:   SCRIPT: [0x8e31ee0]: label 'dos'
15774: libfdisk:    LABEL: [0x8e2f438]: parsing 'c' (dos) partition type
15774: libfdisk: PARTTYPE: [0xf774985c]: returns parsed 'W95 FAT32=20
(LBA)' [] partition type
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' bootable'
15774: libfdisk:      TAB: [0x8e2f0d8]: add entry 0x8e31f98 [start=3D2048=
,=20
end=3D1026047, size=3D1024000,   primary]
15774: libfdisk:   SCRIPT: [0x8e31ee0]: applying script headers
15774: libfdisk:      CXT: [0x8e2f338]: setting reference to script=20
0x8e31ee0
15774: libfdisk:      CXT: [0x8e2f338]: --> switching context to dos!
15774: libfdisk:      CXT: [0x8e2f338]: *** reseting device properties
15774: libfdisk:      CXT: [0x8e2f338]: /dev/sdb: discovering topology...=

15774: libfdisk:      CXT: [0x8e2f338]: initialize libblkid prober
15774: libfdisk:      CXT: [0x8e2f338]: result: log/phy sector size: 512/=
512
15774: libfdisk:      CXT: [0x8e2f338]: result: fdisk/optimal/minimal=20
io: 512/0/512
15774: libfdisk:      CXT: [0x8e2f338]: /dev/sdb: discovering geometry...=

15774: libfdisk:      CXT: [0x8e2f338]: total sectors: 1025610768=20
(ioctl=3D1025610768)
15774: libfdisk:      CXT: [0x8e2f338]: result: C/H/S: 63841/255/63
15774: libfdisk:      CXT: [0x8e2f338]: zeroize in-memory first sector=20
buffer
15774: libfdisk:      CXT: [0x8e2f338]: reading: offset=3D0, size=3D512
15774: libfdisk:      CXT: [0x8e2f338]: appling user device properties
15774: libfdisk:      CXT: [0x8e2f338]: reseting alignment...
15774: libfdisk:      CXT: [0x8e2f338]: alignment reseted to: first=20
LBA=3D2048, last LBA=3D1025610767, grain=3D1048576 [rc=3D0]
15774: libfdisk:      CXT: [0x8e2f338]: new C/H/S: 63841/255/63
15774: libfdisk:      CXT: [0x8e2f338]: new log/phy sector size: 512/512
15774: libfdisk:      CXT: [0x8e2f338]: create a new dos label
15774: libfdisk:    LABEL: DOS: creating new disklabel
15774: libfdisk:      CXT: [0x8e2f338]: zeroize in-memory first sector=20
buffer
15774: libfdisk:      CXT: [0x8e2f338]: first sector protection enabled=20
-- re-reading
15774: libfdisk:      CXT: [0x8e2f338]: reading: offset=3D0, size=3D440
15774: libfdisk:    LABEL: DOS: initialize, first sector buffer 0x8e31cd8=

15774: libfdisk:      ASK: [0x8e32398]: alloc
15774: libfdisk:      ASK: [0x8e32398]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32398]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32398]: reset
15774: libfdisk:      ASK: [0x8e32398]: free
15774: libfdisk:      CXT: [0x8e2f338]: adding new partition 0x8e31f98=20
(start=3D2048, end=3D1026047, size=3D1024000, defaults(start=3Dno, end=3D=
no,=20
partno=3Dno)
15774: libfdisk:    LABEL: DOS: new partition wanted
15774: libfdisk:     PART: [0x8e31f98]: next partno (specified=3D0)
15774: libfdisk:    LABEL: DOS: adding partition 0
15774: libfdisk:    LABEL: DOS: last possible sector for #0 is 1025610767=

15774: libfdisk:      CXT: [0x8e2f338]: LBA 2048 -unchanged-
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1025610767 -aligned-down->=20
1025609728 [grain=3D2048s]
15774: libfdisk:      CXT: [0x8e2f338]: LBA 2048 -unchanged-
15774: libfdisk:      CXT: [0x8e2f338]: LBA 2048=20
range:<2048..1025609728>, result: 2048
15774: libfdisk:    LABEL: DOS: start: wanted=3D2048, low=3D2048,=20
limit=3D1025610767
15774: libfdisk:    LABEL: DOS: start is 2048
15774: libfdisk:    LABEL: DOS: last possible sector for #0 is 1025610767=

15774: libfdisk:    LABEL: DOS: unused sector for #0 is 1025610767
15774: libfdisk:    LABEL: DOS: raw stop: 1026047
15774: libfdisk:    LABEL: DOS: setting partition 0, offset=3D0,=20
start=3D2048, size=3D1024000, sysid=3D0c
15774: libfdisk:    LABEL: DOS: setting 0 partition to changed
15774: libfdisk:      ASK: [0x8e32470]: alloc
15774: libfdisk:      ASK: [0x8e32470]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32470]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32470]: reset
15774: libfdisk:      ASK: [0x8e32470]: free
15774: libfdisk:      CXT: [0x8e2f338]: add partition done (rc=3D0)
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 6
15774: libfdisk:   SCRIPT: [0x8e31ee0]:   parsing buffer
15774: libfdisk:   SCRIPT: [0x8e31ee0]:    parse script line: '/dev/sdb2 =

: start=3D     1026048, size=3D  1024581632, type=3D7'
15774: libfdisk:     PART: [0x8e32038]: alloc
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' start=3D 1026048,=20
size=3D  1024581632, type=3D7'
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' size=3D 1024581632, ty=
pe=3D7'
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing ' type=3D7'
15774: libfdisk:    LABEL: [0x8e2f438]: parsing '7' (dos) partition type
15774: libfdisk: PARTTYPE: [0xf77497f8]: returns parsed=20
'HPFS/NTFS/exFAT' [] partition type
15774: libfdisk:      TAB: [0x8e2f0d8]: add entry 0x8e32038=20
[start=3D1026048, end=3D1025607679, size=3D1024581632,   primary]
15774: libfdisk:      CXT: [0x8e2f338]: adding new partition 0x8e32038=20
(start=3D1026048, end=3D1025607679, size=3D1024581632, defaults(start=3Dn=
o,=20
end=3Dno, partno=3Dno)
15774: libfdisk:    LABEL: DOS: new partition wanted
15774: libfdisk:     PART: [0x8e32038]: next partno (specified=3D1)
15774: libfdisk:    LABEL: DOS: adding partition 1
15774: libfdisk:    LABEL: DOS: last possible sector for #1 is 1025610767=

15774: libfdisk:      CXT: [0x8e2f338]: LBA 1026048 -unchanged-
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1025610767 -aligned-down->=20
1025609728 [grain=3D2048s]
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1026048 -unchanged-
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1026048=20
range:<1026048..1025609728>, result: 1026048
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1026048 -unchanged-
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1025610767 -aligned-down->=20
1025609728 [grain=3D2048s]
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1026048 -unchanged-
15774: libfdisk:      CXT: [0x8e2f338]: LBA 1026048=20
range:<1026048..1025609728>, result: 1026048
15774: libfdisk:    LABEL: DOS: start: wanted=3D1026048, low=3D1026048,=20
limit=3D1025610767
15774: libfdisk:    LABEL: DOS: start is 1026048
15774: libfdisk:    LABEL: DOS: last possible sector for #1 is 1025610767=

15774: libfdisk:    LABEL: DOS: unused sector for #1 is 1025610767
15774: libfdisk:    LABEL: DOS: raw stop: 1025607679
15774: libfdisk:    LABEL: DOS: setting partition 1, offset=3D0,=20
start=3D1026048, size=3D1024581632, sysid=3D07
15774: libfdisk:    LABEL: DOS: setting 1 partition to changed
15774: libfdisk:      ASK: [0x8e32470]: alloc
15774: libfdisk:      ASK: [0x8e32470]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32470]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32470]: reset
15774: libfdisk:      ASK: [0x8e32470]: free
15774: libfdisk:      CXT: [0x8e2f338]: add partition done (rc=3D0)
15774: sfdisk:    PARSE: <---next-line--->
15774: libfdisk:   SCRIPT: [0x8e31ee0]:  parsing line 7
15774: libfdisk:      ASK: [0x8e32470]: alloc
15774: libfdisk:      ASK: [0x8e32470]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32470]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32470]: reset
15774: libfdisk:      ASK: [0x8e32470]: free
15774: libfdisk:      CXT: [0x8e2f338]:  -- get table --
15774: libfdisk:      TAB: [0x8e32358]: alloc
15774: libfdisk:     PART: [0x8e32560]: alloc
15774: libfdisk:      TAB: [0x8e32358]: add entry 0x8e32560 [start=3D2048=
,=20
end=3D1026047, size=3D1024000,   primary]
15774: libfdisk:     PART: [0x8e32698]: alloc
15774: libfdisk:      TAB: [0x8e32358]: add entry 0x8e32698=20
[start=3D1026048, end=3D1025607679, size=3D1024581632,   primary]
15774: libfdisk:      ASK: [0x8e32398]: alloc
15774: libfdisk:      ASK: [0x8e32398]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32398]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32398]: reset
15774: libfdisk:      ASK: [0x8e32398]: free
15774: libfdisk:      TAB: [0x8e32358]: wrong older check
15774: libfdisk:      TAB: [0x8e32358]: reset
15774: libfdisk:      TAB: [0x8e32358]: remove entry 0x8e32560
15774: libfdisk:     PART: [0x8e32560]: reset
15774: libfdisk:     PART: [0x8e32560]: free
15774: libfdisk:      TAB: [0x8e32358]: remove entry 0x8e32698
15774: libfdisk:     PART: [0x8e32698]: reset
15774: libfdisk:     PART: [0x8e32698]: free
15774: libfdisk:      TAB: [0x8e32358]: free
15774: libfdisk:    LABEL: DOS: write PT requested [label-changed: 1,=20
non-pt-changed: 1]
15774: libfdisk:    LABEL: DOS: MBR changed, writting
15774: libfdisk:    LABEL: DOS: writting to sector 0
15774: libfdisk:      ASK: [0x8e32308]: alloc
15774: libfdisk:      ASK: [0x8e32308]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32308]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32308]: reset
15774: libfdisk:      ASK: [0x8e32308]: free
15774: libfdisk:      ASK: [0x8e32398]: alloc
15774: libfdisk:      ASK: [0x8e32398]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32398]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32398]: reset
15774: libfdisk:      ASK: [0x8e32398]: free
15774: libfdisk:      ASK: [0x8e32308]: alloc
15774: libfdisk:      ASK: [0x8e32308]: do_ask for 'info'
15774: libfdisk:      ASK: [0x8e32308]: do_ask done [rc=3D0]
15774: libfdisk:      ASK: [0x8e32308]: reset
15774: libfdisk:      ASK: [0x8e32308]: free
15774: sfdisk:     MISC: bye! [rc=3D0]
Checking that no-one is using this disk right now ... OK

Disk /dev/sdb: 489.1 GiB, 525112713216 bytes, 1025610768 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x18e5ab42

Old situation:

Device     Boot   Start        End    Sectors   Size Id Type
/dev/sdb1  *       2048    1026047    1024000   500M  c W95 FAT32 (LBA)
/dev/sdb2       1026048 1025607679 1024581632 488.6G  7 HPFS/NTFS/exFAT

 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Script header accepted.
 >>> Created a new DOS disklabel with disk identifier 0xb8fbfff6.
Created a new partition 1 of type 'W95 FAT32 (LBA)' and of size 500 MiB.
/dev/sdb2: Created a new partition 2 of type 'HPFS/NTFS/exFAT' and of=20
size 488.6 GiB.
/dev/sdb3:
New situation:

Device     Boot   Start        End    Sectors   Size Id Type
/dev/sdb1  *       2048    1026047    1024000   500M  c W95 FAT32 (LBA)
/dev/sdb2       1026048 1025607679 1024581632 488.6G  7 HPFS/NTFS/exFAT

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.


--=20
Bart=C5=82omiej Solarz-Nies=C5=82uchowski, Administrator WSISiZ
e-mail: Bartlomiej.Solarz-Niesluchowski@wit.edu.pl
tel. 223486547, fax 223486501
JID: solarz@jabber.wit.edu.pl
01-447 Warszawa, ul. Newelska 6, pok=C3=B3j 404, pon.-pt. 8-16
Motto - Jak sobie po=C5=9Bcielisz tak sie wy=C5=9Bpisz



--------------ms060107060107010208050006
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Kryptograficzna sygnatura S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C3owggWIMIIEcKADAgECAhEAzWOh2VGpX5/p2EoYP+5nTTANBgkqhkiG9w0BAQsFADBpMQsw
CQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQtSG9sbGFuZDESMBAGA1UEBxMJQW1zdGVyZGFt
MQ8wDQYDVQQKEwZURVJFTkExHTAbBgNVBAMTFFRFUkVOQSBQZXJzb25hbCBDQSAyMB4XDTE0
MTAxMzAwMDAwMFoXDTE3MTAxMjIzNTk1OVowggFBMQswCQYDVQQGEwJQTDEUMBIGA1UECBML
TWF6b3dpZWNraWUxETAPBgNVBAcTCFdhcnN6YXdhMQ8wDQYDVQQREwYwMS00NDcxFzAVBgNV
BAkTDnVsLiBOZXdlbHNrYSA2MSAwHgYDVQQLExdMYWJvcmF0b3JpYSBLb21wdXRlcm93ZTE7
MDkGA1UEChMyV3l6c3phIFN6a29sYSBJbmZvcm1hdHlraSBTdG9zb3dhbmVqIGkgWmFyemFk
emFuaWExGTAXBgkqhkiG9w0BCQIWCjg0MEBXU0lTSVoxKjAoBgNVBAMMIUJhcnTFgm9taWVq
IFNvbGFyei1OaWVzxYJ1Y2hvd3NraTE5MDcGCSqGSIb3DQEJARYqQmFydGxvbWllai5Tb2xh
cnotTmllc2x1Y2hvd3NraUB3aXQuZWR1LnBsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAlwAAoBfN0M9lTNyF1C51YFnVsVSOP4lH0fZnu4kQacKGtOuO04K995P8Q4l3kTaT
zJVBPfZpm+im5ghVQNDKWmR8cVvMzFlnvmEjTzPrj4i4uf7sz4BFMJV9x7rlBWOC6quBsGIi
xIcDTZ3dgKZmXkzl/EEiPRH0Ng7kwRdXWPCtwbe7pOcPtrM7BkRSGPy6N5unv2m4f2nb7UZ9
kgni49NlMyPrDlhGufhmYvZ6wPXVnGlYlGl+3n44Gj3cUMa3XhV5jyjv94HZEcLmqVv3zPHz
JB4egj7eXDwjHdnC7jSxEw9CctrVhk5h9XHk26P6f44ZwBPF3eT01J+6/A0TYwIDAQABo4IB
TzCCAUswHwYDVR0jBBgwFoAU+5w4I1Ch1wAEmS04BmSQoyYb2+0wHQYDVR0OBBYEFCEtceIk
iaeUVAZyD081M6c1QRKuMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQW
MBQGCCsGAQUFBwMEBggrBgEFBQcDAjAYBgNVHSAEETAPMA0GCysGAQQBsjEBAgIdMD8GA1Ud
HwQ4MDYwNKAyoDCGLmh0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9URVJFTkFQZXJzb25hbENB
Mi5jcmwwcQYIKwYBBQUHAQEEZTBjMDoGCCsGAQUFBzAChi5odHRwOi8vY3J0LnVzZXJ0cnVz
dC5jb20vVEVSRU5BUGVyc29uYWxDQTIuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51
c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQAW1pKjXAk7o2w1jjCxSOfMT7DOjwzO
t6GJImAaBUsczhIYRuzyCegTN7l8FmIEF78AjkHrCwM8zZKEDzc+JzS3qVS7DMFlUNBpiDM4
RZmoqv2gHqkR3/j8+MCP3Du9ZXEgd40cVfWcl4bbpB2FjVm879oET6HxhuFNHYa8Sprs56TF
ANvrn/EjP3hB5BbrHveCbn1M2dSEhl9ojG9YxEmR5k6ooRqGy4LdLTdTOO1iXW42+JFdTKLY
K27cePtzVAZkzzBZLH8rZ2mrC+rwU3EuFXYQDiKRsah+FvLpF55brFBtG8BlIlYMoZrwb8FG
ZxzBtH2NZTEypppmhKntf17dMIIF6jCCA9KgAwIBAgIRAM0n6PuHVxFfdlSNZoQ9l/owDQYJ
KoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYD
VQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYD
VQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE0MTAwOTAw
MDAwMFoXDTI0MTAwODIzNTk1OVowaTELMAkGA1UEBhMCTkwxFjAUBgNVBAgTDU5vb3JkLUhv
bGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMGVEVSRU5BMR0wGwYDVQQDExRU
RVJFTkEgUGVyc29uYWwgQ0EgMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIt/
txlfYTgQu/SsFvalu41zNJsnlZV8L2L22pUwZyCfFo+Y1TUhlh6+3ppy8iN53w4L8oIOeJtW
dlTTCG2cstFjVMDPGDt5qSZg2J/+p5SsClYDkuRhLd2JhKm0XTzF2Xk+G5fSLS4fp9gD2fCu
a7yqFU6vcr2OKpCBuK+sNQgwagGZHUhR92hxhmGYihsg7JbCqv5sGEOclH+2i34wqbxVbOtX
B3rTHkLjuqVTC+rY7/fUz5GKDnraaVq56unRxerjmLKGTNwHcL+tlC4H1RMqkcxukrljaVPQ
nWhJYp0rSvRfwlFJGgTNHUvt/jmjqsVfqwzssyLHU3mJAkTxl70CAwEAAaOCAWswggFnMB8G
A1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBT7nDgjUKHXAASZLTgG
ZJCjJhvb7TAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwGAYDVR0gBBEwDzANBgsrBgEEAbIxAQICHTBQBgNVHR8E
STBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlm
aWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRw
Oi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYB
BQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAECZ
vR9W7r9ievG4g95FRUr9M/saDMcLJonWtk1pFoO4jkJyTBryic4xo+DBk48fW92GukiUQEIc
NGkhGPVMfYFTwp7Cue8yjjyoKMDpJMVx/72iJA0tL+LXbGgedtxxKXGMf1EsE97nDy4xCrer
iELxXBPqt8x9Wscs9go/1uPW4laDLVT/RwQiiGDx/UNZb1ev6RKtRAg6y+Anp5Yd6AUf2/6c
aQ8H9tjrcxZ6nsiNcc5DrFx4hK2KTqZAVfud8HCmBR0ic4WtbRFBd65HKCx5AcN+Usc9I48M
F+7Ohz2ZJSDiAVmNwrMYFTX5cHBTD9Nt26TezyuKQEooR1hx2ODxQqnT+xXOiJxxltZgw4dh
9RT/fyEaIhAFmqJCaTGYqCnVED2MDYTiWJeZ8Ag6qCk99Aqou49IMOiZNdWQCHw97qFlx8Xh
Tc4RfxSFqhYpK1Kb6DouDmuwmRPT0MWuRZNs2fTumA3b08klQkLK0f+OEFJWVAWyRSfWvS/6
v8XPNxzOgtbiSjAX1vixM/5lrNei6JlmJjhgODr+X7ydaAddhvzu5p6hqIsmLRNPoRZkumfj
ppoVkX/X8SSkMg7a6mMXDjl3o4vOD0A8sZ4t/TZTkhXSdxxy2kO8zBk3HOvNnc9JgekNS8ki
K3OaBG7Vv2CPyc0vknfcyGVhzBOAnishMYIDqDCCA6QCAQEwfjBpMQswCQYDVQQGEwJOTDEW
MBQGA1UECBMNTm9vcmQtSG9sbGFuZDESMBAGA1UEBxMJQW1zdGVyZGFtMQ8wDQYDVQQKEwZU
RVJFTkExHTAbBgNVBAMTFFRFUkVOQSBQZXJzb25hbCBDQSAyAhEAzWOh2VGpX5/p2EoYP+5n
TTANBglghkgBZQMEAgEFAKCCAfswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMTcwMjIxMTc1NDUxWjAvBgkqhkiG9w0BCQQxIgQgEAcNWasX/R8JAFrT3IgO
RWETlsQ6kuSOCFaO75eUeTMwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUr
DgMCBzANBggqhkiG9w0DAgIBKDCBjgYJKwYBBAGCNxAEMYGAMH4waTELMAkGA1UEBhMCTkwx
FjAUBgNVBAgTDU5vb3JkLUhvbGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMG
VEVSRU5BMR0wGwYDVQQDExRURVJFTkEgUGVyc29uYWwgQ0EgMgIRAM1jodlRqV+f6dhKGD/u
Z00wgZAGCyqGSIb3DQEJEAILMYGAoH4waTELMAkGA1UEBhMCTkwxFjAUBgNVBAgTDU5vb3Jk
LUhvbGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMGVEVSRU5BMR0wGwYDVQQD
ExRURVJFTkEgUGVyc29uYWwgQ0EgMgIRAM1jodlRqV+f6dhKGD/uZ00wDQYJKoZIhvcNAQEB
BQAEggEAObp5TWkfa0l5B+oeSsmDBQ/xJhd6OHdwQVidMl4lDegCQD8EngQXIwjWIadRwCVm
n46CqnoPMITiqbpxvbXx+8jOnLt8uRfXLhDPvDUccUHBWf8URE2JTLuderTt5WOl9RVXe/U9
Bg/6BGY4/+8V4FjEXMpzQd9ViZaVGfMhrAq4G6qLiKZJFgME6/tGqG6T1rm9wzSz1pQJBAG9
gvP+sI/PE3qbHyPJyw+oKLQanAlbW3BBSS/twiQZ0SHcBmePqjIfK6pYc7RskKEn5Y0Li6F1
GyumObL7PimvROtGt03V9lav3L8RFmTKkoZfBE9I1F56s20IRpk6YhJqmZVx5wAAAAAAAA==
--------------ms060107060107010208050006--
