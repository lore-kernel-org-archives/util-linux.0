Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F8207A32
	for <util-linux@vger.kernel.org>; Thu, 11 Sep 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583312; cv=none; b=muQLKkplYIPZ7dHY7ncMTMaiZLWTDv8aPqNRTq7XKyACOdI+NykE4jEAlJbedLwxPxF42H3SQwp3Y3Q/6kiSPISneaV3gUMF/8tvym8Iq6SjiWPWiVwb1bAnRcN9lYBa1yUEVvgPcwUckILB15icW/wJCX3LGcZta29cSI2nd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583312; c=relaxed/simple;
	bh=KEcOm/PjBmP0JplRUV508W9HE6ImNCOOOnDXvqm0Uuo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IowXTOK9ALPvO0QF9actuyzi+yNVo/H1SxsMZlCMh1JAiVYEJyqa7fu2WWMAL4xaBJN7FSm2kNdqlfEetZa9/0lsnJHJcfQfrdGKZuTvQXdvnhVaruAzjTqRnPOPcDGZKPhLNrV3TS9V5qlE9a7Iz3orG9YEbP6sjPQEPpo3JKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B43EE0w9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B43EE0w9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757583309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/iNt6Q6WT0L1Ge/4pCXcoPunwsiHbPKPsrzRpwrnwb4=;
	b=B43EE0w9WMdM+2WkO3NA6i8WS6xBkqpx/8xsxaZt19O7zFnSa+Cx/dd5Oe532mHo8fTMCM
	rybxhL/GjgJwMMFb3DlBPMKYby/OqbhMcFhyvgbwMgzAfGc0GPOdluydTEQBflOsH/QkGD
	aACoCGYdOSRlWRKAq6fjze36ul+4dQo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-UZrp0fkQOsGe3Rlo3yjxOA-1; Thu,
 11 Sep 2025 05:35:06 -0400
X-MC-Unique: UZrp0fkQOsGe3Rlo3yjxOA-1
X-Mimecast-MFC-AGG-ID: UZrp0fkQOsGe3Rlo3yjxOA_1757583305
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAED81800249
	for <util-linux@vger.kernel.org>; Thu, 11 Sep 2025 09:34:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB0A21944CCA
	for <util-linux@vger.kernel.org>; Thu, 11 Sep 2025 09:34:57 +0000 (UTC)
Date: Thu, 11 Sep 2025 11:34:54 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41.2-rc1
Message-ID: <2z3lcjducw4ntsyg6eoau5io7mgour226q45t2cdx6czrz7h3c@6ehqa6n4v5yl>
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


The util-linux stable release v2.41.2-rc1 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.41.2
 
Feedback and bug reports, as always, are welcomed.
 
The final v2.41.2 release will be next week.

  Karel


util-linux 2.41.2 Release Notes
===============================

bash-completion:
    - fix function name of enosys completion (by Koichi Murase)
    - add choom and coresched (by Karel Zak)

findmnt:
    - add missing newline in --raw, --pair and --list output formats (by Christian Goeschel Ndjomouo)

fsck.cramfs:
    - check buffer size for memcpy() (by Karel Zak)

getopt:
    - document special symbols that should not be used as option characters (by cgoesche)

gitignore:
    - Ignore tests/diff/ and test/output/ (by Jesse Rosenstock)

hardlink:
    - (man) add note note about ULFILEEQ_DEBUG= (by Karel Zak)

include/mount-api-utils:
    - avoid using sys/mount.h (by Karel Zak)

libblkid:
    - (ext) reduce false positive (by 胡玮文)
    - improve UUID_SUB= description (by Karel Zak)

lib/color-names:
    - fix stupid bugs (by Karel Zak)
    - Fix color name canonicalization (by Karel Zak)

libfdisk:
    - (script) improve separator usage in named-fields dump (by Karel Zak)
    - (script) fix device name separator parsing (by Karel Zak)

liblastlog2:
    - markup fixes for man pages (by Mario Blättermann)

libmount:
    - don't report fsconfig errors with "nofail" (by Karel Zak)

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

logger:
    - fix buffer overflow when read stdin (by Karel Zak)
    - fix incorrect warning message when both --file and a message are specified (by Alexander Kappner)

lsblk:
    - fix possible use-after-free (by Karel Zak)
    - fix memory leak [coverity scan] (by Karel Zak)
    - use md as fallback TYPE when md/level empty (by codefiles)

lscpu:
    - New Arm C1 parts (by Jeremy Linton)
    - Add NVIDIA Olympus arm64 core (by Matthew R. Ochs)

man:
    - Fixed incorrect ipcrm options (by Prasanna Paithankar)
    - Replace RETURN VALUE with EXIT STATUS in section 1 (by Jesse Rosenstock)

mkfs.cramfs:
    - avoid uninitialized value [coverity scan] (by Karel Zak)

more:
    - temporarily ignore stdin when waiting for stderr (by Karel Zak)

po-man:
    - merge changes (by Karel Zak)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)

rev:
    - add --zero option to --help output (by Christian Goeschel Ndjomouo)

setpriv:
    - Improve getgroups() Portability (by Karel Zak)

sfdisk:
    - reject spurious arguments for --reorder/--backup-pt-sectors (by Thomas Weißschuh)

tests:
    - add color names test (by Karel Zak)

tests/helpers/test_sigstate.c:
    - explicitly reset SIGINT to default action after trapping (by Hongxu Jia)

zramctl:
    - ignore ENOENT when setting max_comp_streams (by Jiang XueQian)
    - fix MEM-USED column description (by Jérôme Poulin)

Misc:
    - Add missing ;; to -m case (#1) (by Nate Drake)


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

