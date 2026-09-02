Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF83A0E99
	for <util-linux@vger.kernel.org>; Wed,  2 Sep 2026 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337512; cv=none; b=CJ2BF9UWFBvTFYhdjC3XakVvvo3aJoYehG8jPw9f44Z827frNXA6EIF4DcpBA9GG7FSP9ZwynB+QsGtfNzc43g68Whe/XlmqVmW/k+m8NBMGF5iijY7+r4f5D3LJpNcX0cyY200bkfG4Wz7k+9vnLbCXOZu0s3jAv3+2VdyQb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337512; c=relaxed/simple;
	bh=Jd2a9RXvsQf33KLbdgSdyS4W1Br953Py70GyxhjHwfE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qVrVpa5tP8mvv669q0U+uNRfgJZ1PoEBxdbGhjK/4AedNDHKprWYHM5SSp/1o2KBwlYaqBKIa3u8Qy5e0C2QqPzW6xFWZuOrgpZO5q2BO9f0t/zby2z9rjAxUPWU8agSzjyH4LuU8CW4kfNrfo0EEE5F0sN6AQolK4gJ2qX4wAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNm6FkRW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNm6FkRW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788337510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HVqFm8D0vBG1ow64zGx55zGZW/KvA/uA3IdWSxf3nxk=;
	b=ZNm6FkRWEQ7mkDYcQVL35+pk/SoUDo2g7olRPjDUf8iF7UYHT2nFk8TDa0eF/UNaUvqKXP
	vYA7ka8jFoDACZAbQnOrfRhixiNnkGV9cB9LzPnLmBO7GrRq/WYSd26BmU4EIOO5MR755w
	Fj17+JKd1uqC7etmiDGONMLKaUlZp+4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-I6_MlpAWMQm05DSr4ZAqXA-1; Wed,
 02 Sept 2026 04:25:06 -0400
X-MC-Unique: I6_MlpAWMQm05DSr4ZAqXA-1
X-Mimecast-MFC-AGG-ID: I6_MlpAWMQm05DSr4ZAqXA_1788337505
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9998C1955F16;
	Wed,  2 Sep 2026 08:25:05 +0000 (UTC)
Received: from ws (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AAD4426;
	Wed,  2 Sep 2026 08:25:03 +0000 (UTC)
Date: Wed, 2 Sep 2026 10:25:00 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.42.3
Message-ID: <pymhqp55bzgzuuhvjhmo5msoor4xp6ekvtc5xcqhmcyvwf3dbd@5dp2dim4ttzs>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95


The util-linux release v2.42.3 is now available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.42

Feedback and bug reports, as always, are welcomed.

  Karel



util-linux 2.42.3 Release Notes
===============================

Security fixes:

 CVE-2026-76642 - mount(8) post-mount hooks execute after helper failure.
   When an external mount.<type> helper exits nonzero, post-mount hooks
   (X-mount.idmap, X-mount.owner/group/mode) still execute as if the
   mount had succeeded, allowing privileged operations on the
   pre-existing target filesystem.

 CVE-2026-78410 - mount(8) TOCTOU race on source path.
   In restricted (SUID, non-root) mode, the source path is
   canonicalized with realpath() as euid=0, following symlinks through
   user-writable directories.  Additionally, open_tree() follows
   symlinks in intermediate path components.  A local attacker can
   redirect a privileged mount or post-mount ownership change to an
   arbitrary path.

 CVE-2026-78409 - mount(8) X-mount.subdir symlink escape.
   The open_tree() call used to open a subdirectory on a detached mount
   follows symlinks in intermediate path components, allowing escape
   from the detached tree.

 CVE-2026-78408 - nsenter(1), unshare(1) file descriptor leak.
   File descriptors in nsenter and unshare were not created with
   O_CLOEXEC, potentially leaking them across exec.  Added O_CLOEXEC
   as defense in depth.

 wall(1), write(1) - hostname escape sequence injection.
   The CVE-2024-28085 fix sanitized only message bodies; the banner
   headers still interpolated the system hostname without sanitization.
   An unprivileged user can inject terminal escape sequences via a user
   namespace hostname.
   Additional fix for CVE-2024-28085.
   Reported-by: Skyler Ferrante

Changes between v2.42.2 and v2.42.3:

agetty:
    - fix spurious issue file reprinting on reload (by Karel Zak)

bitops:
    - avoid macro redefinition on macOS (by Karel Zak)

build-sys:
    - require lastlog.h for liblastlog2 (by WanBingjiang)

col:
    - guard c_width sign before size_t cast in BS branch (by Aizal Khan)
    - fix cur_col underflow on backspace over a wide char (by Aizal Khan)

disk-utils:
    - fix memory leak in execute function (by Tigran Sogomonian)

hexdump:
    - stop after stdout write errors (by WanBingjiang)

libblkid:
    - befs fix possible load of misaligned address (by Milan Broz)
    - befs fix possible too large shift (by Milan Broz)
    - dos fix 32-bit overflow in partition start/size [coverity CID 503517, 503518] (by Karel Zak)
    - (iso9660) fix out-of-bounds read of root dir record (by Aizal Khan)

libfdisk:
    - fix OOM on GPT with huge partition entries array (by Karel Zak)

lib/fileutils:
    - add ul_openat_resolve() openat2 wrapper (by Karel Zak)

libmount:
    - skip post-mount hooks after failed mount helper [CVE-2026-76642] (by Karel Zak)
    - pin source path with openat2() for restricted users [CVE-2026-78410] (by Karel Zak)
    - restrict source path canonicalization for non-root users [CVE-2026-78410] (by Karel Zak)
    - fix X-mount.subdir symlink following on detached tree [CVE-2026-78409] (by Karel Zak)
    - add mnt_open_tree() helper for safe tree opening (by Karel Zak)
    - fix DBG() macro use (by Karel Zak)
    - reuse existing act fd in mnt_update_start on ro retry (by wangrong)
    - properly end act file in mnt_free_update (by wangrong)
    - don't ignore "/" target in mount --all when target prefix is set (by Karel Zak)

lscpu:
    - remove mmu reference not available in stable/v2.42 (by Karel Zak)
    - add NULL guards for RISC-V ISA functions [coverity CID 503785] (by Karel Zak)

mbsalign:
    - check remaining buffer space before writing hex escapes (by aizu-m)

meson:
    - move header checks before component dependency resolution (by Karel Zak)
    - gate liblastlog2 on lastlog.h (by Thomas Weißschuh)

more:
    - fix out-of-bounds write in get_line() on invalid multibyte input (by logical-misha)

nsenter, unshare:
    - add O_CLOEXEC to all open() calls [CVE-2026-78408] (by Karel Zak)

pg:
    - fix out-of-bounds access past wbuf on a trailing tab (by logical-misha)

po:
    - merge changes (by Karel Zak)
    - update zh_CN.po (from translationproject.org) (by Boyuan Yang)
    - update tr.po (from translationproject.org) (by Emir SARI)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)

po-man:
    - merge changes (by Karel Zak)
    - update pl.po (from translationproject.org) (by Michał Kułach)

tests:
    - (partx) settle udev before checking partition count (by Karel Zak)
    - kill/decode also strip RT0 from signal mask output (by Karel Zak)
    - test_scols_termreduce needs libsmartcols (by Adam Sampson)

unshare:
    - Fix --map-auto regression (by Chris Webb)

wall, write:
    - sanitize hostname in banner header (by Karel Zak)

