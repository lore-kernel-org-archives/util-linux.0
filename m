Return-Path: nik2087@gmail.com
MIME-Version: 1.0
References: <CALY=dt+aJC0aXm6j4wg-T-RbOKAv-+q7NuzMaH_fwPO3Hdss2A@mail.gmail.com>
 <20180510095215.fpxoerxvan7hx3ac@ws.net.home> <CALY=dt+6zebO8jAmW-3R36U5tJEyopzZjJSyTjLDDOutZCLjPg@mail.gmail.com>
In-Reply-To: <CALY=dt+6zebO8jAmW-3R36U5tJEyopzZjJSyTjLDDOutZCLjPg@mail.gmail.com>
From: Nikhil <nik2087@gmail.com>
Date: Thu, 10 May 2018 10:34:04 +0000
Message-ID: <CALY=dtJYdsa5YMtFakfME5JOb0bmYRcak5Ut1L_47dR7z0Zf-w@mail.gmail.com>
Subject: Re: blkid -> attempt to access beyond end of device if start sector
 is > 128
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

output for entire device :

root@ebboard:/home/Leica#  LIBBLKID_DEBUG=all blkid -p -o udev /dev/mmcblk0
535: libblkid:     INIT: library debug mask: 0xffff
535: libblkid:     INIT: library version: 2.30.0 [02-Jun-2017]
Available "LIBBLKID_DEBUG=<name>[,...]|<mask>" debug masks:
    all      [0xffff] : info about all subsystems
    cache    [0x0004] : blkid tags cache
    config   [0x0008] : config file utils
    dev      [0x0010] : device utils
    devname  [0x0020] : /proc/partitions evaluation
    devno    [0x0040] : conversions to device name
    evaluate [0x0080] : tags resolving
    help     [0x0001] : this help
    lowprobe [0x0100] : superblock/raids/partitions probing
    buffer   [0x2000] : low-probing buffers
    probe    [0x0200] : devices verification
    read     [0x0400] : cache parsing
    save     [0x0800] : cache writing
    tag      [0x1000] : tags utils
535: libblkid: LOWPROBE: allocate a new probe 0x6a1a0
535: libblkid: LOWPROBE: zeroize wiper
535: libblkid: LOWPROBE: ready for low-probing, offset=0, size=1000341504
535: libblkid: LOWPROBE: whole-disk: YES, regfile: NO
535: libblkid: LOWPROBE: 0x6a1a0: start probe
535: libblkid: LOWPROBE: zeroize wiper
535: libblkid: LOWPROBE: chain safeprobe superblocks ENABLED
535: libblkid: LOWPROBE: --> starting probing loop [SUBLKS idx=-1]
535: libblkid: LOWPROBE: [0] linux_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0x6a2a8: off=1000275968 len=64
535: libblkid: LOWPROBE:        read 0x6a310: off=1000333312 len=256
535: libblkid: LOWPROBE:        read 0x6a438: off=0 len=256
535: libblkid: LOWPROBE:        read 0x6a560: off=4096 len=256
535: libblkid: LOWPROBE: [1] ddf_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0x6a688: off=1000340992 len=512
535: libblkid: LOWPROBE:        read 0x6a8b0: off=1000209920 len=512
535: libblkid: LOWPROBE: [2] isw_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0x6aad8: off=1000340480 len=48
535: libblkid: LOWPROBE: [3] lsi_mega_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6a688: off=1000340992 len=512 (for
off=1000340992 len=6)
535: libblkid: LOWPROBE: [4] via_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6a688: off=1000340992 len=512 (for
off=1000340992 len=51)
535: libblkid: LOWPROBE: [5] silicon_medley_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6a688: off=1000340992 len=512 (for
off=1000340992 len=512)
535: libblkid: LOWPROBE: [6] nvidia_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6aad8: off=1000340480 len=48 (for
off=1000340480 len=18)
535: libblkid: LOWPROBE: [7] promise_fasttrack_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0x6ab30: off=1000309248 len=24
535: libblkid: LOWPROBE:        read 0x6ab70: off=1000210944 len=24
535: libblkid: LOWPROBE:        read 0x6abb0: off=1000210432 len=24
535: libblkid:   BUFFER:        reuse 0x6a310: off=1000333312 len=256 (for
off=1000333312 len=24)
535: libblkid: LOWPROBE:        read 0x6abf0: off=1000137216 len=24
535: libblkid: LOWPROBE:        read 0x6ac30: off=1000038912 len=24
535: libblkid: LOWPROBE:        read 0x6ac70: off=999995904 len=24
535: libblkid: LOWPROBE:        read 0x6acb0: off=999965184 len=24
535: libblkid: LOWPROBE:        read 0x6acf0: off=999875072 len=24
535: libblkid: LOWPROBE:        read 0x6ad30: off=999842816 len=24
535: libblkid: LOWPROBE:        read 0x6ad70: off=999834112 len=24
535: libblkid: LOWPROBE:        read 0x6adb0: off=999854592 len=24
535: libblkid: LOWPROBE:        read 0x6adf0: off=998760960 len=24
535: libblkid: LOWPROBE: [8] hpt45x_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0x6ae30: off=1000335872 len=4
535: libblkid: LOWPROBE: [9] hpt37x_raid_member:
535: libblkid: LOWPROBE:        read 0x6ae58: off=4096 len=1024
535: libblkid:   BUFFER:        reuse 0x6ae58: off=4096 len=1024 (for
off=4096 len=1024)
535: libblkid: LOWPROBE: [10] adaptec_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6a688: off=1000340992 len=512 (for
off=1000340992 len=512)
535: libblkid: LOWPROBE: [11] jmicron_raid_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6a688: off=1000340992 len=512 (for
off=1000340992 len=6)
535: libblkid: LOWPROBE: [12] bcache:
535: libblkid:   BUFFER:        reuse 0x6ae58: off=4096 len=1024 (for
off=4096 len=1024)
535: libblkid: LOWPROBE: [13] drbd:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0x6b280: off=1000337408 len=4096
535: libblkid: LOWPROBE: [14] drbdmanage_control_volume:
535: libblkid: LOWPROBE:        read 0x6c2a8: off=0 len=1024
535: libblkid: LOWPROBE: [15] drbdproxy_datalog:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [16] LVM2_member:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE:        read 0x6c6d0: off=1024 len=1024
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE: [17] LVM1_member:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [18] DM_snapshot_cow:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [19] DM_verity_hash:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [20] crypto_LUKS:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [21] VMFS_volume_member:
535: libblkid: LOWPROBE:        read 0x6caf8: off=1048576 len=1024
535: libblkid: LOWPROBE: [22] vfat:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE:        magic sboff=510, kboff=0
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=512)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=512)
535: libblkid: LOWPROBE: [23] swsuspend:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE:        read 0x6cf20: off=3072 len=1024
535: libblkid:   BUFFER:        reuse 0x6cf20: off=3072 len=1024 (for
off=3072 len=1024)
535: libblkid:   BUFFER:        reuse 0x6cf20: off=3072 len=1024 (for
off=3072 len=1024)
535: libblkid:   BUFFER:        reuse 0x6cf20: off=3072 len=1024 (for
off=3072 len=1024)
535: libblkid: LOWPROBE:        read 0x6d348: off=7168 len=1024
535: libblkid:   BUFFER:        reuse 0x6d348: off=7168 len=1024 (for
off=7168 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d348: off=7168 len=1024 (for
off=7168 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d348: off=7168 len=1024 (for
off=7168 len=1024)
535: libblkid: LOWPROBE:        read 0x6d770: off=15360 len=1024
535: libblkid:   BUFFER:        reuse 0x6d770: off=15360 len=1024 (for
off=15360 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d770: off=15360 len=1024 (for
off=15360 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d770: off=15360 len=1024 (for
off=15360 len=1024)
535: libblkid: LOWPROBE:        read 0x6db98: off=31744 len=1024
535: libblkid:   BUFFER:        reuse 0x6db98: off=31744 len=1024 (for
off=31744 len=1024)
535: libblkid:   BUFFER:        reuse 0x6db98: off=31744 len=1024 (for
off=31744 len=1024)
535: libblkid:   BUFFER:        reuse 0x6db98: off=31744 len=1024 (for
off=31744 len=1024)
535: libblkid: LOWPROBE:        read 0x6dfc0: off=64512 len=1024
535: libblkid:   BUFFER:        reuse 0x6dfc0: off=64512 len=1024 (for
off=64512 len=1024)
535: libblkid:   BUFFER:        reuse 0x6dfc0: off=64512 len=1024 (for
off=64512 len=1024)
535: libblkid:   BUFFER:        reuse 0x6dfc0: off=64512 len=1024 (for
off=64512 len=1024)
535: libblkid: LOWPROBE: [24] swap:
535: libblkid:   BUFFER:        reuse 0x6cf20: off=3072 len=1024 (for
off=3072 len=1024)
535: libblkid:   BUFFER:        reuse 0x6cf20: off=3072 len=1024 (for
off=3072 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d348: off=7168 len=1024 (for
off=7168 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d348: off=7168 len=1024 (for
off=7168 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d770: off=15360 len=1024 (for
off=15360 len=1024)
535: libblkid:   BUFFER:        reuse 0x6d770: off=15360 len=1024 (for
off=15360 len=1024)
535: libblkid:   BUFFER:        reuse 0x6db98: off=31744 len=1024 (for
off=31744 len=1024)
535: libblkid:   BUFFER:        reuse 0x6db98: off=31744 len=1024 (for
off=31744 len=1024)
535: libblkid:   BUFFER:        reuse 0x6dfc0: off=64512 len=1024 (for
off=64512 len=1024)
535: libblkid:   BUFFER:        reuse 0x6dfc0: off=64512 len=1024 (for
off=64512 len=1024)
535: libblkid: LOWPROBE: [25] xfs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [26] xfs_external_log:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid: LOWPROBE:        read 0xb6ec4028: off=0 len=262144
535: libblkid: LOWPROBE: [27] ext4dev:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE:        magic sboff=56, kboff=1
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=512)
535: libblkid: LOWPROBE: [28] ext4:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE:        magic sboff=56, kboff=1
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=512)
535: libblkid:    PROBE: ext2_sb.compat = 00000038:00008002:00000003
535: libblkid: LOWPROBE: assigning UUID [superblocks]
535: libblkid: LOWPROBE: assigning VERSION [superblocks]
535: libblkid: LOWPROBE: assigning TYPE [superblocks]
535: libblkid: LOWPROBE: assigning USAGE [superblocks]
535: libblkid: LOWPROBE: <-- leaving probing loop (type=ext4) [SUBLKS
idx=28]
535: libblkid: LOWPROBE: saving superblocks values
535: libblkid: LOWPROBE: --> starting probing loop [SUBLKS idx=28]
535: libblkid: LOWPROBE: [29] ext3:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE:        magic sboff=56, kboff=1
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=512)
535: libblkid: LOWPROBE: [30] ext2:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE:        magic sboff=56, kboff=1
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=512)
535: libblkid: LOWPROBE: [31] jbd:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE:        magic sboff=56, kboff=1
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=512)
535: libblkid: LOWPROBE: [32] reiserfs:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=8192 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=8192 len=1024)
535: libblkid: LOWPROBE: [33] reiser4:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid: LOWPROBE: [34] jfs:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid: LOWPROBE: [35] udf:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid: LOWPROBE: [36] iso9660:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=32768 len=1024)
535: libblkid: LOWPROBE: [37] zfs_member:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:    PROBE: probe_zfs

535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=0 len=262144)
535: libblkid: LOWPROBE:        read 0xb6e83028: off=262144 len=262144
535: libblkid: LOWPROBE:        read 0xb6e42028: off=999817216 len=262144
535: libblkid: LOWPROBE:        read 0xb6e01028: off=1000079360 len=262144
535: libblkid: LOWPROBE: [38] hfsplus:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE: [39] hfs:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE: [40] ufs:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=0 len=1377)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=8192 len=1377)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1377)
535: libblkid:   BUFFER:        reuse 0xb6e83028: off=262144 len=262144
(for off=262144 len=1377)
535: libblkid: LOWPROBE: [41] hpfs:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=8192 len=1024)
535: libblkid: LOWPROBE: [42] sysv:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=512
len=512)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=9728 len=512)
535: libblkid:   BUFFER:        reuse 0x6d770: off=15360 len=1024 (for
off=15872 len=512)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=18944 len=512)
535: libblkid: LOWPROBE: [43] xenix:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=2048 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=2048 len=1024)
535: libblkid: LOWPROBE: [44] ntfs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [45] ReFS:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [46] cramfs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [47] romfs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [48] minix:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE: [49] gfs:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid: LOWPROBE: [50] gfs2:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid: LOWPROBE: [51] ocfs:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=8192 len=1024)
535: libblkid: LOWPROBE: [52] ocfs2:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=2048 len=1024)
535: libblkid:   BUFFER:        reuse 0x6ae58: off=4096 len=1024 (for
off=4096 len=1024)
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=8192 len=1024)
535: libblkid: LOWPROBE: [53] oracleasm:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [54] vxfs:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE: [55] squashfs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [56] squashfs3:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [57] nss:
535: libblkid:   BUFFER:        reuse 0x6ae58: off=4096 len=1024 (for
off=4096 len=1024)
535: libblkid: LOWPROBE: [58] btrfs:
535: libblkid:   BUFFER:        reuse 0xb6ec4028: off=0 len=262144 (for
off=65536 len=1024)
535: libblkid: LOWPROBE: [59] ubifs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [60] bfs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [61] VMFS:
535: libblkid: LOWPROBE:        read 0x6e520: off=2097152 len=1024
535: libblkid: LOWPROBE: [62] befs:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [63] nilfs2:
535: libblkid: LOWPROBE:        call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid:   BUFFER:        reuse 0x6b280: off=1000337408 len=4096 (for
off=1000337408 len=1024)
535: libblkid: LOWPROBE: [64] exfat:
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE: [65] f2fs:
535: libblkid:   BUFFER:        reuse 0x6c6d0: off=1024 len=1024 (for
off=1024 len=1024)
535: libblkid: LOWPROBE: <-- leaving probing loop (failed=1) [SUBLKS idx=65]
535: libblkid: LOWPROBE: appending values
535: libblkid: LOWPROBE: freeing values list
535: libblkid: LOWPROBE: chain safeprobe topology DISABLED
535: libblkid: LOWPROBE: chain safeprobe partitions ENABLED
535: libblkid: LOWPROBE: Resetting partitions values
535: libblkid: LOWPROBE: --> starting probing loop [PARTS idx=-1]
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE:        magic sboff=510, kboff=0
535: libblkid: LOWPROBE: dos: ---> call probefunc()
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=512)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=1024)
535: libblkid: LOWPROBE:        magic sboff=510, kboff=0
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=512)
535: libblkid:   BUFFER:        reuse 0x6c2a8: off=0 len=1024 (for off=0
len=512)
535: libblkid: LOWPROBE: returning TYPE value
535: libblkid: LOWPROBE: dos: <--- (rc = 0)
535: libblkid: LOWPROBE: assigning PTTYPE [partitions]
535: libblkid: LOWPROBE: <-- leaving probing loop (type=dos) [PARTS idx=3]
535: libblkid: LOWPROBE: parts: start probing for partition entry
535: libblkid: LOWPROBE: parts: end probing for partition entry [nothing]
535: libblkid: LOWPROBE: partitions probe done [rc=0]
535: libblkid: LOWPROBE: 0x6a1a0: end probe
535: libblkid: LOWPROBE: zeroize wiper
535: libblkid: LOWPROBE: returning UUID value
ID_FS_UUID=61b1cc4e-c6fa-4257-bdc2-8a359dd8696a
ID_FS_UUID_ENC=61b1cc4e-c6fa-4257-bdc2-8a359dd8696a
535: libblkid: LOWPROBE: returning VERSION value
ID_FS_VERSION=1.0
535: libblkid: LOWPROBE: returning TYPE value
ID_FS_TYPE=ext4
535: libblkid: LOWPROBE: returning USAGE value
ID_FS_USAGE=filesystem
535: libblkid: LOWPROBE: returning PTTYPE value
ID_PART_TABLE_TYPE=dos
535: libblkid:   BUFFER: Resetting probing buffers pr=0x6a1a0
535: libblkid:   BUFFER:  remove buffer: 0x6a2a8 [off=1000275968, len=64]
535: libblkid:   BUFFER:  remove buffer: 0x6a310 [off=1000333312, len=256]
535: libblkid:   BUFFER:  remove buffer: 0x6a438 [off=0, len=256]
535: libblkid:   BUFFER:  remove buffer: 0x6a560 [off=4096, len=256]
535: libblkid:   BUFFER:  remove buffer: 0x6a688 [off=1000340992, len=512]
535: libblkid:   BUFFER:  remove buffer: 0x6a8b0 [off=1000209920, len=512]
535: libblkid:   BUFFER:  remove buffer: 0x6aad8 [off=1000340480, len=48]
535: libblkid:   BUFFER:  remove buffer: 0x6ab30 [off=1000309248, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6ab70 [off=1000210944, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6abb0 [off=1000210432, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6abf0 [off=1000137216, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6ac30 [off=1000038912, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6ac70 [off=999995904, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6acb0 [off=999965184, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6acf0 [off=999875072, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6ad30 [off=999842816, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6ad70 [off=999834112, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6adb0 [off=999854592, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6adf0 [off=998760960, len=24]
535: libblkid:   BUFFER:  remove buffer: 0x6ae30 [off=1000335872, len=4]
535: libblkid:   BUFFER:  remove buffer: 0x6ae58 [off=4096, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6b280 [off=1000337408, len=4096]
535: libblkid:   BUFFER:  remove buffer: 0x6c2a8 [off=0, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6c6d0 [off=1024, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6caf8 [off=1048576, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6cf20 [off=3072, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6d348 [off=7168, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6d770 [off=15360, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6db98 [off=31744, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0x6dfc0 [off=64512, len=1024]
535: libblkid:   BUFFER:  remove buffer: 0xb6ec4028 [off=0, len=262144]
535: libblkid:   BUFFER:  remove buffer: 0xb6e83028 [off=262144, len=262144]
535: libblkid:   BUFFER:  remove buffer: 0xb6e42028 [off=999817216,
len=262144]
535: libblkid:   BUFFER:  remove buffer: 0xb6e01028 [off=1000079360,
len=262144]
535: libblkid:   BUFFER:  remove buffer: 0x6e520 [off=2097152, len=1024]
535: libblkid: LOWPROBE:  buffers summary: 1065108 bytes by 35 read() calls
535: libblkid: LOWPROBE: resetting results pr=0x6a1a0
535: libblkid: LOWPROBE:  free value UUID
535: libblkid: LOWPROBE:  free value VERSION
535: libblkid: LOWPROBE:  free value TYPE
535: libblkid: LOWPROBE:  free value USAGE
535: libblkid: LOWPROBE:  free value PTTYPE
535: libblkid: LOWPROBE: free probe 0x6a1a0
On Thu, May 10, 2018 at 3:43 PM Nikhil <nik2087@gmail.com> wrote:

> Thanks a lot for reply.  Here's the output:

> root@ebboard:~# blkid -v
> blkid from util-linux 2.30  (libblkid 2.30.0, 02-Jun-2017)

> root@ebboard:~#  LIBBLKID_DEBUG=all blkid -p -o udev /dev/mmcblk0p1
> 491: libblkid:     INIT: library debug mask: 0xffff
> 491: libblkid:     INIT: library ver[  129.635888] attempt to access
beyond
> end of device
> sion: 2.30.0 [02-Jun-2017]
> Avai[  129.641600] unknown-block(179,0): rw=0, want=1953793, limit=1953792
> lable "LIBBLKID_DEBUG=<name>[,..[  129.650266] Buffer I/O error on dev
> mmcblk0p1, logical block 244207, async page read
> .]|<mask>" debug masks:
>      all      [0xffff] : info about all subsystems
>      cache    [0x0004] : blkid tags cache
>      config   [0x0008] : config file utils
>      dev      [0x0010] : device utils
>      devname  [0x0020] : /proc/partitions evaluation
>      devno    [0x0040] : conversions to device name
>      evaluate [0x0080] : tags resolving
>      help     [0x0001] : this help
>      lowprobe [0x0100] : superblock/raids/partitions probing
>      buffer   [0x2000] : low-probing buffers
>      probe    [0x0200] : devices verification
>      read     [0x0400] : cache parsing
>      save     [0x0800] : cache writing
>      tag      [0x1000] : tags utils
> 491: libblkid: LOWPROBE: allocate a new probe 0x1d731a0
> 491: libblkid: LOWPROBE: zeroize wiper
> 491: libblkid: LOWPROBE: ready for low-probing, offset=0, size=1000275456
> 491: libblkid: LOWPROBE: whole-disk: NO, regfile: NO
> 491: libblkid: LOWPROBE: 0x1d731a0: start probe
> 491: libblkid: LOWPROBE: zeroize wiper
> 491: libblkid: LOWPROBE: chain safeprobe superblocks ENABLED
> 491: libblkid: LOWPROBE: --> starting probing loop [SUBLKS idx=-1]
> 491: libblkid: LOWPROBE: [0] linux_raid_member:
> 491: libblkid: LOWPROBE:        call probefunc()
> 491: libblkid: LOWPROBE:        read 0x1d73410: off=1000144896 len=64
> 491: libblkid: LOWPROBE:        read 0x1d73478: off=1000263680 len=256
> 491: libblkid: LOWPROBE:        read 0x1d735a0: off=0 len=256
> 491: libblkid: LOWPROBE:        read 0x1d736c8: off=4096 len=256
> 491: libblkid: LOWPROBE: [1] ddf_raid_member:
> 491: libblkid: LOWPROBE:        call probefunc()
> 491: libblkid: LOWPROBE:        read 0x1d737f0: off=1000274944 len=512
> 491: libblkid: LOWPROBE:        read failed: Input/output error
> 491: libblkid: LOWPROBE: <-- leaving probing loop (failed=-5) [SUBLKS
idx=1]
> 491: libblkid: LOWPROBE: freeing values list
> 491: libblkid: LOWPROBE: 0x1d731a0: end probe
> 491: libblkid: LOWPROBE: zeroize wiper
> 491: libblkid:   BUFFER: Resetting probing buffers pr=0x1d731a0
> 491: libblkid:   BUFFER:  remove buffer: 0x1d73410 [off=1000144896,
len=64]
> 491: libblkid:   BUFFER:  remove buffer: 0x1d73478 [off=1000263680,
len=256]
> 491: libblkid:   BUFFER:  remove buffer: 0x1d735a0 [off=0, len=256]
> 491: libblkid:   BUFFER:  remove buffer: 0x1d736c8 [off=4096, len=256]
> 491: libblkid: LOWPROBE:  buffers summary: 832 bytes by 4 read() calls
> 491: libblkid: LOWPROBE: free probe 0x1d731a0
> On Thu, May 10, 2018 at 3:22 PM Karel Zak <kzak@redhat.com> wrote:

> > On Thu, May 10, 2018 at 09:00:36AM +0000, Nikhil wrote:
> > > We have i.Mx35 based embedded system running Linux 4.14.  The
> distribution
> > > is built using yocto (rocko branch).  Before we moved on to Linux 4.14
> we
> > > used Linux 2.6, distribution was again built using yocto(danny
branch).
> > > After upgrade to rocko and linux 4.14, we see some error messages on
the
> > > console on executing blkid.  These messages appear for the SD card.
> Error
> > > messages appear only if SD Card is mounted and if the start sector for
> sd
> > > card is 129 or more,  doesnt appear is start sector is 128 or less.
> > >
> > > Error Message:
> > > root@ebboard:~# blkid
> > > [ 8707.475004] attempt to access beyond end of device
> > > [ 8707.479894] unknown-block(179,0): rw=0, want=1953793, limit=1953792
> > > [ 8707.488054] Buffer I/O error on dev mmcblk0p1, logical block
244207,
> > > async page read
> > >
> > > fdisk output:
> > > root@ebboard:~# fdisk -ul
> > >
> > > Disk /dev/mmcblk0: 1000 MB, 1000341504 bytes
> > > 4 heads, 16 sectors/track, 30528 cylinders, total 1953792 sectors
> > > Units = sectors of 1 * 512 = 512 bytes
> > >
> > >          Device Boot      Start         End      Blocks  Id System
> > > /dev/mmcblk0p1             129     1953791      976831+  6 FAT16
> > >
> > > If anyone has any idea as to why these warnings are printed depending
on
> > > whether the start sector is > 128  would be very much helpful.
Thanks.

> > Maybe kernel returns incorrect size for the device, or it's blkid bug.

> > Can you try

> >      LIBBLKID_DEBUG=all blkid -p -o udev /dev/mmcblk0p1

> > or for /dev/mmcblk0 (not sure if kernel reports it for whole-disk
> > probing or for the partition).

> > util-linux version ? (blkid -V).

> >      Karel

> > --
> >   Karel Zak  <kzak@redhat.com>
> >   http://karelzak.blogspot.com
