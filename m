Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D24A1D
	for <util-linux@vger.kernel.org>; Thu, 19 Jun 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322411; cv=none; b=LuyVWPxY2YaEbt2J2eIHELVZWnATqAQg+848xpoPymoiayeHJJuR8vP6iUiZEW5EgY183d0oituB/qmptygZpWpj6VfahogtOpAm2xVPCXYav+lMVkoExKlg2WorJGFNJq0Bg88e+vdshsxYA046a01S5Pq3REQOc65gBPDTwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322411; c=relaxed/simple;
	bh=d4mQgIsnChf9dcbrzRfYd4UyMwSmuS2nNFI7wBVokRk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lijOF928TP2Ss7frZOlgGivUfcaMfUrT4VsObXUlqxEo/QVetjRtu6uRSQk6Y69VvIk8u1P+cOStQuWnyeqqcb5NByd+Hzbq8wkmLQuXZslewBvlh+VCc1PZyrNvpmXFi9cUatgDNsk5JHIgAMKEW2iZQrcGmAf6/pTK4MDo6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2C9BJ8O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2C9BJ8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750322408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k0pT9Dh+OWloycpsIk4NtfyXI0Ej8iHKvU43AvjbFO8=;
	b=h2C9BJ8OItXn60SbUyyksOotYxN5CgiYCQeC6DpcLYlyK3rT9ni9Vln70JS3QfT6+TEexc
	7DykiU0zchzWHEux1VHNKFtcOIE+chiFkxcT39tfv9Woh1h9cTNUUrysTttLe/mcJ9+cQv
	Dn+n3f7+wYkwgdm3SbG3qdZtEIuqv3U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-zNpKIDJ5MEyhfC8SmbRNZw-1; Thu,
 19 Jun 2025 04:40:05 -0400
X-MC-Unique: zNpKIDJ5MEyhfC8SmbRNZw-1
X-Mimecast-MFC-AGG-ID: zNpKIDJ5MEyhfC8SmbRNZw_1750322405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E11BD195608F
	for <util-linux@vger.kernel.org>; Thu, 19 Jun 2025 08:40:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E0961800285
	for <util-linux@vger.kernel.org>; Thu, 19 Jun 2025 08:40:02 +0000 (UTC)
Date: Thu, 19 Jun 2025 10:39:59 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.41.1 plan
Message-ID: <al3esfoztviujvzqjk33kgxqxsbs2abuwzpqp223aptzbz7l7w@ewu7b36wwxny>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


Hi all,

I'd like to release the stable update v2.41.1 ASAP (tomorrow?). The current 
log for the stable/v2.41 branch is below.

Do you need anything else in the release?

    Karel


autotools:
    - don't use wide-character ncurses if --disable-widechar (by Karel Zak)

cfdisk:
    - fix memory leak and possible NULL dereference [gcc-analyzer] (by Karel Zak)

column:
    - fix compiler warning for non-widechar compilation (by Karel Zak)

fdformat:
    - use size_t and ssize_t (by Karel Zak)

fdisk:
    - fix possible memory leak (by Karel Zak)

fdisk,partx:
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

findmnt:
    - fix -k option parsing regression (by Karel Zak)

hardlink:
    - define more function as inline (by Karel Zak)
    - fix performance regression (inefficient signal evaluation) (by Karel Zak)
    - Use macro for verbose output (by Karel Zak)

include/cctype:
    - fix string comparison (by Karel Zak)

include/mount-api-utils:
    - include linux/unistd.h (by Thomas Weiﬂschuh)

libblkid:
    - Fix crash while parsing config with libeconf (by Stanislav Brabec)
    - befs fix underflow (by Milan Broz)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

libblkid/src/topology/dm:
    - fix fscanf return value check to match expected number of parsed items (by Mingjie Shen)

libfdisk:
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

libmount:
    - (subdir) restrict for real mounts only (by Karel Zak)
    - (subdir) remove unused code (by Karel Zak)
    - avoid calling memset() unnecessarily (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)
    - fix --no-canonicalize regression (by Karel Zak)

libuuid:
    - fix uuid_time on macOS without attribute((alias)) (by Eugene Gershnik)

lsblk:
    - use ID_PART_ENTRY_SCHEME as fallback for PTTYPE (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

lscpu:
    - fix possible buffer overflow in cpuinfo parser (by Karel Zak)
    - Fix loongarch op-mode output with recent kernel (by Xi Ruoyao)

lsfd:
    - (bug fix) scan the protocol field of /proc/net/packet as a hex number (by Masatake YAMATO)
    - fix the description for PACKET.PROTOCOL column (by Masatake YAMATO)

lsns:
    - enhance compilation without USE_NS_GET_API (by Karel Zak)
    - fix undefined reference to add_namespace_for_nsfd #3483 (by Thomas Devoogdt)

meson:
    - add feature for translated documentation (by Thomas Weiﬂschuh)
    - remove tinfo dependency from 'more' (by Thomas Weiﬂschuh)
    - fix manadocs for libsmartcols and libblkid (by Karel Zak)
    - fix po-man installation (by Karel Zak)

misc:
    - never include wchar.h (by Karel Zak)

more:
    - fix broken ':!command' command key (by cgoesche)
    - fix implicit previous shell_line execution #3508 (by cgoesche)

mount:
    - (man) add missing word (by Jakub Wilk)

namespace.h:
    - fix compilation on Linux < 4.10 (by Thomas Devoogdt)

tests:
    - (test_mkfds::mapped-packet-socket) add a new parameter, protocol (by Masatake YAMATO)

treewide:
    - add ul_ to parse_timestamp() function name (by Karel Zak)
    - add ul_ to parse_switch() function name (by Stanislav Brabec)
    - add ul_ to parse_size() function name (by Karel Zak)
    - add ul_ to parse_range() function name (by Karel Zak)
    - fix optional arguments usage (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

Wipefs:
    - improve --all descriptions for whole-disks (by Karel Zak)

Misc:
    - Do not call exit() on code ending in shared libraries (by Cristian RodrÌguez)
    - remove two leftover license lines from colors.{c,h} (by Benno Schulenberg)
    - remove "Copyright (C) ...." notes from files that claim no copyright (by Benno Schulenberg)
    - correct the full name of the GPL in various files (by Benno Schulenberg)
    - Make scols_column_set_data_func docs visible (by FeRD (Frank Dana))
    - Do not use strerror on shared libraries (by Cristian RodrÌguez)
    - Fix typo in blkdiscard docs (by pls-no-hack)
    - lib/fileeq.c Fix a typo in message. (by Masanari Iida)


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

