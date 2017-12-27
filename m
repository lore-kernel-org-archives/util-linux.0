Return-Path: pali.rohar@gmail.com
Date: Wed, 27 Dec 2017 11:14:29 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
	=?utf-8?Q?Vojt=C4=9Bch?= Vladyka <rain@vojtechvladyka.cz>
Subject: fsck command line API
Message-ID: <20171227101429.bisgfv5wumxcqiqp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Hello!

Vojtěch Vladyka is working on a new fsck tool udffsck for UDF filesystem
[1] and I would like to know if there is a some standardized command line
API for fsck tools, so s new udffsck would be compatible.

In util-linux repository there is some generic wrapper fsck which starts
correct filesystem fsck tool... And probably systemd has own wrapper
which do similar thing.

Are there already defined some set of command line arguments which are
expected for fsck tools? Or exit status values from those tools?

Also, lot of filesystems store information if last usage/mount was
correctly synchronized and unmounted. E.g. FAT has dirty bit, ext4 has
journal clean state, UDF has integrity field... and in most cases when
fsck is started at boot time it make sense to skip fsck data check
routine if filesystem state is clean (last time properly unmounted). Is
there some command line API to tell fsck tool if it should do full disk
check (including data) or do it conditionally if filesystem is in dirty
state?

[1] - https://github.com/pali/udftools/pull/7

-- 
Pali Rohár
pali.rohar@gmail.com
