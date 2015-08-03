Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52992 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbbHCKvz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Aug 2015 06:51:55 -0400
Date: Mon, 3 Aug 2015 12:51:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: add fsck.minix checks
Message-ID: <20150803105152.GG2619@ws.net.home>
References: <1438540140-959-1-git-send-email-kerolasa@iki.fi>
 <1438540140-959-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438540140-959-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 02, 2015 at 07:29:00PM +0100, Sami Kerola wrote:
>  tests/expected/minix/fsck-images-auto-fix     |  31 ++++++++++++
>  tests/expected/minix/fsck-images-broken-root  |   7 +++
>  tests/expected/minix/fsck-images-bug.773892   |   1 +
>  tests/expected/minix/fsck-images-check-blocks |   9 ++++
>  tests/expected/minix/fsck-images-v1c14        |   9 ++++
>  tests/expected/minix/fsck-images-v1c30        |   9 ++++
>  tests/expected/minix/fsck-images-v2c14        |   9 ++++
>  tests/expected/minix/fsck-images-v2c30        |   9 ++++
>  tests/expected/minix/fsck-images-v3c60        |   9 ++++
>  tests/ts/minix/broken-root                    | Bin 0 -> 5120 bytes
>  tests/ts/minix/debian.bug.773892              | Bin 0 -> 16384 bytes
>  tests/ts/minix/fsck-images                    |  67 ++++++++++++++++++++++++++

Applied, thanks.

> +ts_check_test_command "$TS_CMD_FSCKMINIX"
> +ts_check_test_command "$TS_HELPER_MKFS_MINIX"
> +
> +export MKFS_MINIX_TEST_SECOND_SINCE_EPOCH='1438460212'

You forgot that the filesystem inodes also contains UID and GIT and
mkfs.minix uses getuid()... so the final checksum depends on used
account :-)

Fixed, I have updated the checksums and enabled the tests for root
(UID=0) only.

> +check_minix_fs_type() {
> +	ts_init_subtest $1
> +	dd if=/dev/zero bs=1024 count=16 of=$TS_OUTDIR/$1 >/dev/null 2>&1

$TS_OUTDIR/$1 is outside subtest namespace, fixed to use ${TS_OUTPUT}.img

> +echo "42" > $TS_OUTDIR/badlist
> +check_minix_fs_type 'check-blocks' "-l $TS_OUTDIR/badlist -c"
> +rm -f $TS_OUTDIR/badlist

same here. Fixed.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
