Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E401D63C5
	for <util-linux@vger.kernel.org>; Wed,  9 Apr 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191406; cv=none; b=G6g8pz2PQam5pA24OiN3c59cMpbTJBUfL+cyGX2oIYGHpmuIuMNPz2FMZrB+Go919yAVSTHarH6sQbsvUczQngF24vSiRws3qs6Uo8Kj8yde/WFgb3E3J8aTkAG/MqjqosCtFQwHlsmA2Ae0l7olXCQEMF23Kl9qRJZLXZ7nkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191406; c=relaxed/simple;
	bh=PGcxUUYRf+gF+VUej3hgi8WeXytN5v9MUvA3uN+/jq0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nRj4OChUN+CUOh3ci/czk7g/mF15Xoam3ckkC7i+JZggXxb21wMJyf46+DHxMABJY69oVvz0BN6B5QuxQQ9ZPCeQURV0W0pHnqIL5I9xuaw6KMDB6agiI8yuYcHEgAccKy2WRqJBSDgxjM54q+epJqtWCn2KPdgDCa5xoJcqgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Kn69Wn8/; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Kn69Wn8/"
X-KPN-MessageId: 3296f021-1526-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3296f021-1526-11f0-a82d-005056abad63;
	Wed, 09 Apr 2025 11:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=QvS0Aa/7JWDKp9x/H7zVyNHzliZx9rnB5DkBh8rrUtA=;
	b=Kn69Wn8/qakphcusFC7B5MxED8uQHINYLGxIc6XcfYGN3ABL4x8PKwQUmgb51XfQIZ0YwurLRbTgU
	 HqZB5E66oQ+v35tAXg7tpQNEJVJLNBLprHty/RILtb4276dukgdDXQ5Le9KyrVjwSZjhjRqwYmffTp
	 OpO7F/MWJZjW/jiI=
X-KPN-MID: 33|n884T2uKM+CdvGV0NL4YdYjKRTBkslgwyN1brMXp5EsUsFR2jzE5bna8XffnvMh
 Xv22ljx8kDJzklzlUFp9Tz+ava75MACZObQWE+XM12k8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aAyJXHMw3qh9YbdGACT1jROUlhQ/pt/uE78NCR7P0+qzfA3gEjOauQBgURvv8DW
 G+tQ19YqBoLRwNXLI4sW8cQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 249a97b3-1526-11f0-959d-005056abf0db;
	Wed, 09 Apr 2025 11:36:41 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] setarch: (man) correct the markup of the synopsis and of two options
Date: Wed,  9 Apr 2025 11:36:35 +0200
Message-ID: <20250409093635.6973-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second line of the synopsis as it is unneeded (it is covered
by the first line since argument "arch" became optional) and distracts
from the similarity/contrast between the other two lines.

Mark "arch" in the new second synopsis line in italics, as it is a
placeholder, not a literal.

Also, improve some wording, reduce redundancy by reshuffling the --pid
option, and remove a redudant -v from an example.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/setarch.8.adoc | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sys-utils/setarch.8.adoc b/sys-utils/setarch.8.adoc
index 1d8c390b3..9d716648f 100644
--- a/sys-utils/setarch.8.adoc
+++ b/sys-utils/setarch.8.adoc
@@ -14,45 +14,46 @@ setarch - change reported architecture in new program environment and/or set per
 
 *setarch* [_arch_] [options] [_program_ [_argument_...]]
 
-*setarch* *--list*|*-h*|*-V*
-
-*arch* [options] [_program_ [_argument_...]]
+_arch_ [options] [_program_ [_argument_...]]
 
 == DESCRIPTION
 
-*setarch* modifies execution domains and process personality flags.
+*setarch* modifies the execution domain and process personality flags.
 
-The execution domains currently only affects the output of *uname -m*. For example, on an AMD64 system, running *setarch i386* _program_ will cause _program_ to see i686 instead of _x86_64_ as the machine type. It can also be used to set various personality options. The default _program_ is */bin/sh*.
+The execution domain currently only affects the output of *uname -m*.
+For example, on an AMD64 system, running *setarch i386* _program_ will
+cause _program_ to see *i686* instead of *x86_64* as the machine type.
+The default _program_ is */bin/sh*.
 
-Since version 2.33 the _arch_ command line argument is optional and *setarch* may be used to change personality flags (ADDR_LIMIT_*, SHORT_INODE, etc) without modification of the execution domain.
+Since version 2.33, the _arch_ command-line argument is optional
+and *setarch* may be used to change personality flags (ADDR_LIMIT_3GB,
+SHORT_INODE, etc) without modification of the execution domain.
 
 == OPTIONS
 
 *--list*::
 List the architectures that *setarch* knows about. Whether *setarch* can actually set each of these architectures depends on the running kernel.
 
-*--show[=personality]*::
+*--show*[**=**_personality_]::
 Show the currently active personality and flags.
-If the *personality* argument is provided, it is shown instead of the current one.
-*personality* is a hexadecimal number with values was described in *sys/personality.h*.
-+
-If *--pid=pid* option is provided, show them of the specifies process.
+If the _personality_ argument is provided, that personality is shown instead of the current one.
+_personality_ is a hexadecimal number whose possible values are described in *sys/personality.h*.
+
+*-p*, **--pid=**_pid_::
+When used with *--show*, show the personality and flags of the specified process.
 
 *--uname-2.6*::
-Causes the _program_ to see a kernel version number beginning with 2.6. Turns on *UNAME26*.
+Causes the specified _program_ to see a kernel version number beginning with 2.6. Turns on *UNAME26*.
 
 *-v*, *--verbose*::
 Be verbose.
 
 *-3*, *--3gb*::
-Specifies _program_ should use a maximum of 3GB of address space. Supported on x86. Turns on *ADDR_LIMIT_3GB*.
+The specified _program_ should use a maximum of 3GB of address space. Supported on x86. Turns on *ADDR_LIMIT_3GB*.
 
 *--4gb*::
 This option has no effect. It is retained for backward compatibility only, and may be removed in future releases.
 
-*-p*, *--pid=pid*::
-With *--show* option, show the currently active personality and flags of the specifies process.
-
 *-B*, *--32bit*::
 Limit the address space to 32 bits to emulate hardware. Supported on ARM and Alpha. Turns on *ADDR_LIMIT_32BIT*.
 
@@ -82,12 +83,12 @@ SVr4 bug emulation that will set *mmap*(2) page zero as read-only. Use when _pro
 
 include::man-common/help-version.adoc[]
 
-== EXAMPLE
+== EXAMPLES
 
 ....
 setarch --addr-no-randomize mytestprog
 setarch ppc32 rpmbuild --target=ppc --rebuild foo.src.rpm
-setarch ppc32 -v -vL3 rpmbuild --target=ppc --rebuild bar.src.rpm
+setarch ppc32 -vL3 rpmbuild --target=ppc --rebuild bar.src.rpm
 setarch ppc32 --32bit rpmbuild --target=ppc --rebuild foo.src.rpm
 setarch --show
 setarch --show=$(cat /proc/9284/personality)
-- 
2.48.1

