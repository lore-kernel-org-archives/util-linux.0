Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C63EFD0C
	for <util-linux@vger.kernel.org>; Mon, 18 May 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102321; cv=none; b=MeiSoq9bCz0VRVGzkhwRJ+o2NcKk/7MOrYBacj79i/I2PyukQTg8uGYfOlSvM5Orkv8hpXYKaZas+H8sJ622XmGTKEpfTBFpWHCDNVurB2KYYRS/JAttl9N29v7bAChK0UbJn8ntTZly62wl0CqMeFoeU3tAFzA4oMhqsbpen9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102321; c=relaxed/simple;
	bh=y9IrFHxJ2X8R/utRW5u4PT3weT7dUqFYMfTJZevEJ+4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F3lv27v32LCrfcY9MvGSM4SG8i2j1zAmzNPBnZxACzxIdepXO5FK2NMIxzCqlzDxN7JDSlWcwxhO0e7c6tdSEic0UhA567a3J+VnMlm9kRbjEfH8QwOzoyXXY0oMAypcLd6zkmknRlXrOk6gmrhnmGtfU/1YSiVSFRy2xslLCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsvlwsI3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsvlwsI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779102314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HiWhQGjMnbplsBQRs1ms9ouzJDhPmjIwzLuFkVbLDrI=;
	b=MsvlwsI3lIdcA4twmD6iGEYyGMVrqI43D0Ea/RGMG83rHjejvuo0jtSV8IWP62l9RRufg2
	BKoQX71c4tklI6LonU2Rt0ZqvVTsw4/YM+uaFVSVfE8aR61hAIerBG+pwuz5Xqg6GpDBxY
	Tg9YEJmuFg0pF/WJ3rQu4dzaPry4uyU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-aYCYjZKkN4yttHuxPlRxww-1; Mon,
 18 May 2026 07:05:12 -0400
X-MC-Unique: aYCYjZKkN4yttHuxPlRxww-1
X-Mimecast-MFC-AGG-ID: aYCYjZKkN4yttHuxPlRxww_1779102311
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08951195605B;
	Mon, 18 May 2026 11:05:11 +0000 (UTC)
Received: from ws (unknown [10.44.49.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB1871800352;
	Mon, 18 May 2026 11:05:08 +0000 (UTC)
Date: Mon, 18 May 2026 13:05:05 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.42.1
Message-ID: <dryjs4vfzzysrhuxa4khf7frezdmouv6ys5nqsx7u46nvk4mg6@z4o37akcrh6y>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The util-linux release v2.42.1 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.42/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux v2.42.1 Release Notes
================================

agetty:
    - Always call chdir after chroot (by Tobias Stoeckmann)

autotools:
    - Fix setpriv build with econf (by Tobias Stoeckmann)

bits:
    - use getline() to avoid stdin input truncation (by WanBingjiang)
    - prevent unsigned integer underflow and long-lived loop (by Christian Goeschel Ndjomouo)

build:
    - (copyfilerange) include syscall header check for fallback (by Christian Goeschel Ndjomouo)
    - Fix --disable-copyfilerange (by Tobias Stoeckmann)

build-sys:
    - drop libcommon_shells from binaries that only need ul_default_shell (by Karel Zak)

cfdisk:
    - fix memory leak of original_layout table (by Karel Zak)

chrt:
    - Fix confusing error messages when priority argument is required (by Rong Zhang)
    - Only show current scheduling policy when pid is given (by Rong Zhang)
    - pass correct integer types to printf (by Thomas Weißschuh)
    - (man) explain which kernel config options are needed for SCHED_EXT (by Christian Goeschel Ndjomouo)

ci:
    - use GCC 15 (by Thomas Weißschuh)
    - run 'make checkusage' only for autotools build (by Thomas Weißschuh)

CI:
    - replace ntp with ntpsec (by Karel Zak)

column:
    - fix missing out-of-bounds check in table reordering (by Christian Goeschel Ndjomouo)

copyfilerange:
    - (man) fix swapped offsets in command example (by Štěpán Němec)

dmesg:
    - fix out-of-bounds read when parsing malformed kmsg file (by WanBingjiang)

docs:
    - clarify wipefs --force description for partition-table signatures (by AndyLau-SOC)

eject:
    - tolerate ILLEGAL REQUEST on ALLOW_MEDIUM_REMOVAL (by Alessandro Ratti)

fallocate:
    - (man) mention supported file systems for --insert-range (by Christian Goeschel Ndjomouo)

fdisk:
    - fix trailing whitespace in user reply from readline completion (by Leonid Znamenok)

fincore:
    - (tests) fix tmpfs detection for out-of-tree builds (by Leonid Znamenok)

flock:
    - re-enable the initial shell selection logic (by Christian Goeschel Ndjomouo)

fsck.minix(man):
    - Fix asciidoctor table (by Tobias Stoeckmann)

hardlink:
    - avoid format string error for dev_t (by Thomas Weißschuh)

include:
    - (fileutils.h) add fallback for the copy_file_range syscall (by Christian Goeschel Ndjomouo)

ipcutils:
    - use memset explicitly to fill bpf_attr with zero (by Masatake YAMATO)

irqtop:
    - add vw_printw() fallback for slang builds (by Karel Zak)

irqtop/lsirq:
    - Handle EOF in get_irqinfo (by Tobias Stoeckmann)

last:
    - fix phantom detection for unset loginuid and X11 sessions (by Karel Zak)

lib:
    - split ul_default_shell() from shells.c into default_shell.c (by Karel Zak)
    - (cpuset.c) dont calculate allocation size for 0 ncpus (by Christian Goeschel Ndjomouo)

libblkid:
    - Fix typo in probe_zfs (by Tobias Stoeckmann)
    - Fix type access in zfs_extract_guid_name (by Tobias Stoeckmann)
    - Fix debug OOB read in zfs_process_value (by Tobias Stoeckmann)
    - Fix parse_dev debug output (by Tobias Stoeckmann)
    - Ignore secondary LUKS2 header in blkid_do_safeprobe() (by silentcreek)
    - reiserfs add block size validation for reiser4 (by Karel Zak)
    - erofs validate blkszbits before checksum calculation (by Karel Zak)
    - exfs avoid 32-bit overflow in rextsize validation (by Karel Zak)
    - solaris use 64-bit for partition offset calculations (by Karel Zak)
    - bsd use 64-bit for partition offset calculations (by Karel Zak)
    - mac use 64-bit for partition offset calculations (by Karel Zak)
    - dos use 64-bit for partition offset calculations (by Karel Zak)
    - udf avoid 32-bit overflow in offset calculations (by Karel Zak)
    - vfat avoid 32-bit overflow in offset calculations (by Karel Zak)
    - ubi fix probe return values (by Karel Zak)
    - f2fs tighten log_blocksize validation (by Karel Zak)
    - nilfs fix byte order and block size validation (by Karel Zak)
    - gpt fix wiper offset to use sector size (by Karel Zak)
    - udf cap descriptor sequence iteration count (by Karel Zak)
    - bcache add missing NULL check (by Karel Zak)
    - bsd read enough data to cover disklabel struct (by Karel Zak)
    - befs improve bounds checking in B+ tree search (by Karel Zak)
    - ntfs improve integer overflow checks (by Karel Zak)
    - introduce sysfs_devno_is_dm_hidden() for pre-open check (by Zdenek Kabelac)

libcommon:
    - move pidfd-utils.c to Linux-only sources (by Karel Zak)

liblastlog2:
    - (tests) avoid log spam (by Thomas Weißschuh)
    - wait on busy SQLite connections (by WanBingjiang)

libmount:
    - return btrfs rootfs from get_btrfs_fs_root() (by Karel Zak)
    - use match_source for mountinfo comparison (by Karel Zak)

lib/pidutils, lib/pidfd-utils:
    - use _() instead of N_() in err() calls (by Karel Zak)

lib/pwdutils:
    - fix compiler warning [-Werror=maybe-uninitialized] (by Karel Zak)

libsmartcols:
    - drop superfluous call yo yylex_init() (by Thomas Weißschuh)
    - (tests) fix failure reporting in filter test (by Thomas Weißschuh)
    - (tests) fix filter test name (by Thomas Weißschuh)
    - Ignore -Wsign-compare in filter-scanner.l (by Thomas Weißschuh)

libuser:
    - fix misleading error message (by Christian Goeschel Ndjomouo)

login:
    - Clean up PAM resources on error path (by Tobias Stoeckmann)

login-utils/auth:
    - Drop pam_setcred (by Tobias Stoeckmann)

lsblk(man):
    - Add COLORS section (by Tobias Stoeckmann)

lsclocks:
    - add missing newline character in option description (by Christian Goeschel Ndjomouo)

lscpu(man):
    - Move options into correct section (by Tobias Stoeckmann)

lsfd:
    - use memset explicitly to fill bpf_attr with zero (by Masatake YAMATO)

meson:
    - check slang headers only when slang library is found (by Karel Zak)
    - rename logindefs_c to lib_common_logindefs (by Karel Zak)
    - split shells.c out of lib_common into lib_common_shells (by Karel Zak)
    - respect build-dmesg for test_dmesg (by Thomas Weißschuh)
    - test for statx::stx_mnt_id in sys/stat.h (by Thomas Weißschuh)

mkfs.cramfs:
    - Consider -i only once (by Tobias Stoeckmann)
    - Add -p padding only once (by Tobias Stoeckmann)
    - Improve file size check (by Tobias Stoeckmann)

mkswap:
    - Fix --file chmod(2) check when file exists (by Johannes Wüller)

more:
    - align MORE_SHELL_LINES semantics with less(1) (by Karel Zak, Christian Goeschel Ndjomouo)

newgrp:
    - Correctly handle getline error (by Tobias Stoeckmann)

nsenter:
    - Fix AT_HANDLE_FID on musl (by Aleksi Hannula)

pidfd-utils:
    - Fix pidfd_get_inode declaration (by Tobias Stoeckmann)

po:
    - merge changes (by Karel Zak)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pt.po (from translationproject.org) (by Pedro Albuquerque)
    - update pl.po (from translationproject.org) (by Jakub Bogusz)
    - update ja.po (from translationproject.org) (by YOSHIDA Hideki)
    - update et.po (from translationproject.org) (by Toomas Soome)
    - update cs.po (from translationproject.org) (by Petr Písař)

po-man:
    - merge changes (by Karel Zak)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)

po-man/po4a:
    - Add missing manual pages (by Tobias Stoeckmann)

readprofile:
    - (man) clarify not designed for privilege-elevation use (by Karel Zak)

script:
    - fix "--" separator when used as option argument (by Karel Zak)
    - fix command and command_norm memory leaks (by Karel Zak)
    - fix backward compatibility for options after non-option args (by Karel Zak)

scriptreplay(man):
    - Add right arrow documentation (by koraynilay)

strutils:
    - fix printf formats (by Thomas Weißschuh)

su:
    - Clean up PAM resources on all error paths (by Tobias Stoeckmann)
    - fix grammar on man page (by Christian Goeschel Ndjomouo)

su-common:
    - revert "su pass arguments after <user> to shell" (by Christian Goeschel Ndjomouo)

terminal-colors.d:
    - (man) re-apply improvements lost in merge (by Benno Schulenberg)

tests:
    - (lsfd/mkfds-udp*) make UDPLite related test cases skippable (by Masatake YAMATO)
    - (lsfd/option-inet{,-udp}) make UDPLite related test case skippable (by Masatake YAMATO)
    - (lsfd) add a function checking the availability of UDPLite socket (by Masatake YAMATO)
    - (lsfd::mkfds-udp) fix confusion between UDP and UDPLite (by Masatake YAMATO)
    - (test_mkfds) use memset explicitly to fill bpf_attr with zero (by Masatake YAMATO)
    - (ipcs/limits) skip when /proc/sys/kernel is read-only (by Karel Zak)
    - (bits) add --width tests for invalid values (by Christian Goeschel Ndjomouo)
    - add btrfs RAID is-mounted test for libmount (by Karel Zak)

tests/functions.sh:
    - consider '+' for metadata in kernel version parsing (by Christian Goeschel Ndjomouo)

tools:
    - (compare-buildsys) suppress common lines in diff output (by Karel Zak)

tools/git-tp-sync:
    - update po4a.cfg language list on sync (by Karel Zak)

write:
    - cleanup indentation and whitespace (by Karel Zak)
    - use mem2strcpy() for utmp strings (by Karel Zak)
    - always use utmp as fallback (by Karel Zak)

write, mesg:
    - add S_ISCHR() check for terminal device paths (by Karel Zak)

Misc:
    - Remove obsolete comment since 2015 (by Julien Nabet)
    - Link against libcommon_logindefs.la and libcommon_shells.la (by Stanislav Brabec)
    - Fix build with libeconf (by Stanislav Brabec)
    - [po-man] Add missing languages to po4a.cfg (by Mario Blättermann)



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

