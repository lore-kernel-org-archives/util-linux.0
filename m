Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CB3A1E8A
	for <util-linux@vger.kernel.org>; Tue, 24 Feb 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946745; cv=none; b=CGn1AIshSe4ks7objifXxa9gwPDOpnWxQvHT3LoIZ5yx+mxCNhuMD0D34d6tQgAG5YNCIRrDrzPgTSFd+E1WUerSupfvvXo0kHCXSbW7+TuzKl6DfNKNYph7xXg5G2SKuOV7ffJ/G148iDMuSdaYYMzlunlC1MCCpL1Wp7/a0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946745; c=relaxed/simple;
	bh=zFdUteBjkjrBN+4UCuKx4rkhw73ukD7keAgl0PwUePU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZCTgB8wwvpgRhiACX0QzxQnG0Kr12OI9zrihMZqoqt8lSIZgJPYNcHxRo7I/l+4te5eUvuIKVRsif+JIJzckD4+Dch9/kR4ht3Gd55FXmXHqc90Col8B6FfSDNb+Dpa/4rbfD4zilpdiPMYR6ZN7RRorZoOARBKTFhqB1orri5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=I3GR5NhX; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="I3GR5NhX"
X-KPN-MessageId: ebd68e6a-1194-11f1-92a0-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ebd68e6a-1194-11f1-92a0-005056aba152;
	Tue, 24 Feb 2026 16:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=z6J/TJlZbqyWYl0K9yDQP1VfWKT+V1RnJ5SEfJHo0i0=;
	b=I3GR5NhXrZUwfWMYFE1N7bcVzdAiGpufU1vqQOMgUGBLiNim3R1eRqSVgo4cCztgHLz/YoYcndSTU
	 p/SOjjCWDPXz+gYpxdKEvE1qmK2puTkFOx+qxBeq1bWo+sAzaLexXWKelSnqq/vYzODi0IQ2XXfNMC
	 C+5QFpHv37Kj2m7Q=
X-KPN-MID: 33|cCy5OZZdJB4C0Uqpl74nvVkqSWZJ/Owi+ayIZCGehggIKO0tRYWbq3BMn4mFmzC
 N9tVm6jKibxPNUV3x6UDG/pBdYQA8MdFxat2Tvgi6SWU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Wsk0mF0qhBO19kpjtR6S7F/pWzMOu/224LhUMjF9Tu6Fq6J78BXC6BEvVJw7V6D
 xO8pdVmTFX7raLPDpUzvIyg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id ebc75660-1194-11f1-8011-005056ab7447;
	Tue, 24 Feb 2026 16:24:33 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] fdisk: (man) correct the markup + punctuation of two option descriptions
Date: Tue, 24 Feb 2026 16:24:22 +0100
Message-ID: <20260224152422.52931-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not colorize 'dos' and 'cylinders' as if they were placeholders --
they are literal example values.

Also, use a semicolon where a comma will not do.  And remove three
redundant blank lines.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/fdisk.8.adoc | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/disk-utils/fdisk.8.adoc b/disk-utils/fdisk.8.adoc
index 7f2f6a42f..515ddee3f 100644
--- a/disk-utils/fdisk.8.adoc
+++ b/disk-utils/fdisk.8.adoc
@@ -48,7 +48,7 @@ Specify the sector size of the disk. Valid values are 512, 1024, 2048, and 4096.
 Don't erase the beginning of the first disk sector when creating a new disk label. This feature is supported for GPT and MBR.
 
 *-c*, *--compatibility*[**=**_mode_]::
-Specify the compatibility mode, 'dos' or 'nondos'. The default is non-DOS mode. For backward compatibility, it is possible to use the option without the _mode_ argument -- then the default is used. Note that the optional _mode_ argument cannot be separated from the *-c* option by a space, the correct form is for example *-c*=_dos_.
+Specify the compatibility mode: 'dos' or 'nondos'. The default is non-DOS mode. For backward compatibility, it is possible to use the option without the _mode_ argument -- then the default is used. Note that the optional _mode_ argument cannot be separated from the *-c* option by a space; the correct form is *-c=dos*, for example.
 
 *-L*, *--color*[**=**_when_]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled; for the current built-in default see the *--help* output. See also the *COLORS* section.
@@ -88,7 +88,7 @@ Print the size in 512-byte sectors of each given block device. This option is DE
 Enable support only for disklabels of the specified _type_, and disable support for all other types.
 
 *-u*, *--units*[**=**_unit_]::
-When listing partition tables, show sizes in 'sectors' or in 'cylinders'. The default is to show sizes in sectors. For backward compatibility, it is possible to use the option without the _unit_ argument -- then the default is used. Note that the optional _unit_ argument cannot be separated from the *-u* option by a space, the correct form is for example '**-u=**__cylinders__'.
+When listing partition tables, show sizes in 'sectors' or in 'cylinders'. The default is to show sizes in sectors. For backward compatibility, it is possible to use the option without the _unit_ argument -- then the default is used. Note that the optional _unit_ argument cannot be separated from the *-u* option by a space; the correct form is *-u=cylinders*, for example.
 
 *-C*, *--cylinders* _number_::
 Specify the _number_ of cylinders of the disk. I have no idea why anybody would want to do so.
@@ -115,17 +115,14 @@ The _partition_ is a device name followed by a partition number. For example, _/
 
 == SIZES
 
-
 //TRANSLATORS: Keep {plus} untranslated.
 The "last sector" dialog accepts partition size specified by number of sectors or by {plus}/-<size>{K,B,M,G,...} notation.
 
-
 //TRANSLATORS: Keep {plus} untranslated.
 If the size is prefixed by '{plus}' then it is interpreted as relative to the partition first sector. If the size is prefixed by '-' then it is interpreted as relative to the high limit (last available sector for the partition).
 
 In the case the size is specified in bytes, then the number may be followed by the multiplicative suffixes KiB (1024 bytes), MiB (1024*1024 bytes), and so on for GiB, TiB, PiB, EiB, ZiB and YiB. The "iB" is optional, e.g., "K" has the same meaning as "KiB".
 
-
 //TRANSLATORS: Keep {plus} untranslated.
 The relative sizes if specified with multiplicative suffixes (e.g. +100MiB) are always aligned according to device I/O limits. The {plus}/-<size>{K,B,M,G,...} notation is recommended.
 
-- 
2.53.0

