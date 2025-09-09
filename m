Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60D2264D9
	for <util-linux@vger.kernel.org>; Tue,  9 Sep 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415750; cv=none; b=RzW7Iz7hoC2bP3r8W8F+fb15DYY4q5MmaK8FoDSBS7oMiXDKKwcZm8oTcYLSfpV3kL2PGbxf6HkALVHaNnMzxBjF9TPKkDiNv8bJ7owMdxa1g0UvBFG2ZgUFxxmDGlRT5LSY0s1gS/lRWt+3HkzXLjDbpE91L7crar87evfZ5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415750; c=relaxed/simple;
	bh=NResK2b7yA6ciPFVJ45BKiuklB+4AMOD6BpHppfm3D0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aECZ/kcGqN/SQg5kKK0UMHlN7dkZf/jodVw5SszEGvkr4qxg7FR0lqrTVh/dyuVLkVIxgBlV8ZoFay08Rrwdeq6dIVtie7bDI0I9XmbKLbXCWDYH+dWpWP8T3Y0vYjQiYdR3ps3pxAz8x3JdAv4RUG4vbF9/7J+HZB9qZOHoOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EogdwADL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EogdwADL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jNob1aJaBRB8mvTecB1di6Ua4BBM1iPNFw7uYhL5arw=;
	b=EogdwADLKBPNrXEfLpmSQKLtDBz5oLM5IkOEFxTFZ/QHz4bFNpybIgjX7y3LIdP0KIy/nt
	MXIAPHg3OFxmeeWxDlHSvDLgHAuTVyIHjiM7Q2Dv8eDHLiUaXDjQpk4vqlx4KENFrSJwha
	MUmWXI44AZHg8ZODTQ8sGcaqpXEOduE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-ZZC_mFNGOpi0uPDfxWWaSg-1; Tue,
 09 Sep 2025 07:02:25 -0400
X-MC-Unique: ZZC_mFNGOpi0uPDfxWWaSg-1
X-Mimecast-MFC-AGG-ID: ZZC_mFNGOpi0uPDfxWWaSg_1757415744
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B3E2195609F
	for <util-linux@vger.kernel.org>; Tue,  9 Sep 2025 11:02:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D56AA1956095
	for <util-linux@vger.kernel.org>; Tue,  9 Sep 2025 11:02:22 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:02:19 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: plan for stable v2.41.2 release
Message-ID: <w4vjett5ctole4m2kdvxv44y4g5ozmbkmva6cofx34p4c6fjf3@szhuecb5ydrv>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi all,

I plan to release v2.41.2, a stable maintenance release, next week.
The stable/v2.41 branch has been updated with relevant commits.
Suggestions and pull requests are welcome.

I may prepare v2.41.2-rc1 for translators this Friday. We usually
don’t do -rc builds for stable updates, but if there is demand from
translators, I can provide one.

Note that the large changes to the man pages (formatting, etc.) are
not included, as I’m not sure we can easily backport everything, and
it would also break translations.

The current log is below.

  Karel


autotools:
    - don't use wide-character ncurses if --disable-widechar (by Karel Zak)

bash-completion:
    - fix function name of enosys completion (by Koichi Murase)
    - add choom and coresched (by Karel Zak)

build-sys:
    - update release dates (by Karel Zak)

cfdisk:
    - fix memory leak and possible NULL dereference [gcc-analyzer] (by Karel Zak)

column:
    - fix compiler warning for non-widechar compilation (by Karel Zak)

docs:
    - add v2.41.1-ReleaseNotes (by Karel Zak)

fdformat:
    - use size_t and ssize_t (by Karel Zak)

fdisk:
    - fix possible memory leak (by Karel Zak)

fdisk,partx:
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

findmnt:
    - add missing newline in --raw, --pair and --list output formats (by Christian Goeschel Ndjomouo)
    - fix -k option parsing regression (by Karel Zak)

fsck.cramfs:
    - check buffer size for memcpy() (by Karel Zak)

getopt:
    - document special symbols that should not be used as option characters (by cgoesche)

gitignore:
    - Ignore tests/diff/ and test/output/ (by Jesse Rosenstock)

hardlink:
    - (man) add note note about ULFILEEQ_DEBUG= (by Karel Zak)
    - define more function as inline (by Karel Zak)
    - fix performance regression (inefficient signal evaluation) (by Karel Zak)
    - Use macro for verbose output (by Karel Zak)

include/cctype:
    - fix string comparison (by Karel Zak)

include/mount-api-utils:
    - avoid using sys/mount.h (by Karel Zak)
    - include linux/unistd.h (by Thomas Weißschuh)

ldattach:
    - add ifndef BOTHER (by Karel Zak)

libblkid:
    - (ext) reduce false positive (by 胡玮文)
    - improve UUID_SUB= description (by Karel Zak)
    - Fix crash while parsing config with libeconf (by Stanislav Brabec)
    - befs fix underflow (by Milan Broz)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

libblkid/src/topology/dm:
    - fix fscanf return value check to match expected number of parsed items (by Mingjie Shen)

lib/color-names:
    - fix stupid bugs (by Karel Zak)
    - Fix color name canonicalization (by Karel Zak)

libfdisk:
    - (script) improve separator usage in named-fields dump (by Karel Zak)
    - (script) fix device name separator parsing (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

liblastlog2:
    - markup fixes for man pages (by Mario Blättermann)

libmount:
    - (subdir) restrict for real mounts only (by Karel Zak)
    - (subdir) remove unused code (by Karel Zak)
    - avoid calling memset() unnecessarily (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)
    - fix --no-canonicalize regression (by Karel Zak)

lib/path:
    - avoid double free() for cpusets (by Karel Zak)

lib/strutils:
    - add ul_ prefix to strrep() and strrem() functions (by Karel Zak)
    - add ul_ prefix to split() function (by Karel Zak)
    - add ul_ prefix to strappend() functions (by Karel Zak)
    - add ul_ prefix to strconcat() functions (by Karel Zak)
    - add ul_ prefix to startswith() and endswith() (by Karel Zak)

lib/strv:
    - use ul_ prefix for strv functions (by Karel Zak)

libuuid:
    - fix uuid_time on macOS without attribute((alias)) (by Eugene Gershnik)

logger:
    - fix incorrect warning message when both --file and a message are specified (by Alexander Kappner)

lsblk:
    - fix possible use-after-free (by Karel Zak)
    - fix memory leak [coverity scan] (by Karel Zak)
    - use md as fallback TYPE when md/level empty (by codefiles)
    - use ID_PART_ENTRY_SCHEME as fallback for PTTYPE (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

lscpu:
    - Add NVIDIA Olympus arm64 core (by Matthew R. Ochs)
    - fix possible buffer overflow in cpuinfo parser (by Karel Zak)
    - Fix loongarch op-mode output with recent kernel (by Xi Ruoyao)

lsfd:
    - (bug fix) scan the protocol field of /proc/net/packet as a hex number (by Masatake YAMATO)
    - fix the description for PACKET.PROTOCOL column (by Masatake YAMATO)

lsns:
    - enhance compilation without USE_NS_GET_API (by Karel Zak)
    - fix undefined reference to add_namespace_for_nsfd #3483 (by Thomas Devoogdt)

man:
    - Fixed incorrect ipcrm options (by Prasanna Paithankar)
    - Replace RETURN VALUE with EXIT STATUS in section 1 (by Jesse Rosenstock)

meson:
    - add feature for translated documentation (by Thomas Weißschuh)
    - remove tinfo dependency from 'more' (by Thomas Weißschuh)
    - fix manadocs for libsmartcols and libblkid (by Karel Zak)
    - fix po-man installation (by Karel Zak)

misc:
    - never include wchar.h (by Karel Zak)

mkfs.cramfs:
    - avoid uninitialized value [coverity scan] (by Karel Zak)

more:
    - temporarily ignore stdin when waiting for stderr (by Karel Zak)
    - fix broken ':!command' command key (by cgoesche)
    - fix implicit previous shell_line execution #3508 (by cgoesche)

mount:
    - (man) add missing word (by Jakub Wilk)

namespace.h:
    - fix compilation on Linux < 4.10 (by Thomas Devoogdt)

rev:
    - add --zero option to --help output (by Christian Goeschel Ndjomouo)

setpriv:
    - Improve getgroups() Portability (by Karel Zak)

sfdisk:
    - reject spurious arguments for --reorder/--backup-pt-sectors (by Thomas Weißschuh)

tests:
    - add color names test (by Karel Zak)
    - (test_mkfds::mapped-packet-socket) add a new parameter, protocol (by Masatake YAMATO)

tests/helpers/test_sigstate.c:
    - explicitly reset SIGINT to default action after trapping (by Hongxu Jia)

treewide:
    - add ul_ to parse_timestamp() function name (by Karel Zak)
    - add ul_ to parse_switch() function name (by Stanislav Brabec)
    - add ul_ to parse_size() function name (by Karel Zak)
    - add ul_ to parse_range() function name (by Karel Zak)
    - fix optional arguments usage (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

Wipefs:
    - improve --all descriptions for whole-disks (by Karel Zak)

zramctl:
    - ignore ENOENT when setting max_comp_streams (by Jiang XueQian)
    - fix MEM-USED column description (by Jérôme Poulin)

Misc:
    - Add missing ;; to -m case (#1) (by Nate Drake)
    - Do not call exit() on code ending in shared libraries (by Cristian Rodríguez)
    - remove two leftover license lines from colors.{c,h} (by Benno Schulenberg)
    - remove "Copyright (C) ...." notes from files that claim no copyright (by Benno Schulenberg)
    - correct the full name of the GPL in various files (by Benno Schulenberg)
    - Make scols_column_set_data_func docs visible (by FeRD (Frank Dana))
    - Do not use strerror on shared libraries (by Cristian Rodríguez)
    - Fix typo in blkdiscard docs (by pls-no-hack)
    - lib/fileeq.c Fix a typo in message. (by Masanari Iida)

