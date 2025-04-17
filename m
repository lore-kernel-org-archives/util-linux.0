Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B9189B8C
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883380; cv=none; b=t9UQK5ZtjEUojAGcpbynm8mswK9CnWFLqOvgHQiDffzPgUsTR3gkDV8Kg2n3ZaHkEXn3IlP9w9kcUmid8RlxKk7cFfOPJ+5bOEsnNZgtV3CxhqFyxAJGoSEdOUmPy6Z1lXrswbvCZOE+GL0idL/eJBcTulo47qTg1+lgjygd7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883380; c=relaxed/simple;
	bh=D31FHWdeckN1jLDc6hPcvyWCUdrfYrqm1TOHGeqK9Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUHjJ+dQHYY8ocLvSiOIsVxQoOSOo2naFXYDuwu4fd3XWiA5RIaObGi57GKNsuWIc8oZhhn47gGonUywtvZOgtwDitvk5Rak5X38layvkQ9ebMIa11z9OKbRHRu9HC9Iis6qZezLyliRCU/EYbfyHvNFfEkx44uV1hLb+Wm4fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FhK0hDzN; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FhK0hDzN"
X-KPN-MessageId: 3f6e5314-1b71-11f0-b8e8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3f6e5314-1b71-11f0-b8e8-005056999439;
	Thu, 17 Apr 2025 11:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=j2Q9RxPDyI3UJqaHcolpHYWAz5ffqCWzvqrl6rsrkA0=;
	b=FhK0hDzNUnKlJZdFcxzgMU91hw7chNfnUSz4AKPdV4jH2JRodslXogQCMo4YY1ZHE+m8vuHBy0aUp
	 aG8lbv7a/m8Iz4J7SnJsr4S8C3SGlq5p/8lql/fdRaEIBWnQC4Vn8698+yQ7JuW7+pPDcqZMEawPnd
	 khYGD+PTFmiAn1dg=
X-KPN-MID: 33|k5YdLn3ubWCgmTabBaW8+TKjXdc/W3n4cViKkp4Onytf1hbGZiRFEvl5v2GsvYa
 4qJzQ+LI+6HLVPQl7hf6NZNjV8eQJctPowxJkMF+uM7Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|DpGJmYUIrU6HmSRc929VVzmcHxSVNSICrS5xC7dhA1irSwZ2TJQiTtQ967Y9XZG
 AkiDcu7gEmvv2gcyjcDlqAQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1e10ce61-1b71-11f0-9da2-00505699b758;
	Thu, 17 Apr 2025 11:48:29 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Robin Jarry <robin@jarry.cc>
Subject: [PATCH 01/10] bits: (man) normalize the markup and improve some layout
Date: Thu, 17 Apr 2025 11:48:15 +0200
Message-ID: <20250417094825.20870-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The convention in man pages is: to put command arguments in lowercase
and without angle brackets (these are for --help texts), and without
unneeded abbreviations.  Literal values (as in some examples) should
be in bold, not in italics.

CC: Robin Jarry <robin@jarry.cc>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/bits.1.adoc | 80 ++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/text-utils/bits.1.adoc b/text-utils/bits.1.adoc
index 0a55583ec..6c7bfebd4 100644
--- a/text-utils/bits.1.adoc
+++ b/text-utils/bits.1.adoc
@@ -20,56 +20,60 @@ Copyright (c) 2024 Robin Jarry
 
 == NAME
 
-bits - convert bit masks from/to various formats
+bits - convert bit masks or lists from/to various formats
 
 == SYNOPSIS
 
-*bits* [*-h*] [*-V*] [*-w* _<NUM>_] [_<MODE>_] [_<MASK_OR_LIST>_...]
+*bits* [*-h*] [*-V*] [*-w* _number_] [_mode_] [_mask_|_list_]...
 
 == DESCRIPTION
 
-The *bits* utility converts bit masks into various formats. It supports
-combining multiple masks together using bitwise operations.
+The *bits* utility converts between bit masks and bit lists.
+It supports combining multiple masks or lists using bitwise operations.
 
 == POSITIONAL ARGUMENTS
 
-_<MASK_OR_LIST>_::
-A set of bits specified as a hexadecimal mask value (e.g. _0xeec2_) or as
-a comma-separated list of bit IDs.
+_mask_::
+A set of bits specified as a hexadecimal mask value
+(for example: *0xeec2*).
+_list_::
+A set of bits specified as a comma-separated list of bit IDs
+(for example: *1,5,29,32*).
 
-If no argument is specified, the sets of bits will be read from standard input;
-one group per line.
+If no argument is specified, the sets of bits will be read from
+standard input, one group per line.
 
-Consecutive ids can be compressed as ranges (e.g. _5,6,7,8,9,10_ -> _5-10_).
+Consecutive IDs can be compressed as ranges
+(for example: *5,6,7,8,9,10* -> *5-10*).
 
-Optionally, if an argument starts with a comma, it will be parsed as a single
-hexadecimal mask split in 32bit groups (e.g. _,00014000,00000000,00020000_ ->
-_17,78,80_).
+Optionally, if an argument starts with a comma, it will be
+parsed as a single hexadecimal mask split in 32-bit groups
+(for example: *,00014000,00000000,00020000* -> *17,78,80*).
 
-By default all groups will be OR'ed together. If a group has one of the
-following prefixes, it will be combined with the resulting mask using
-a different binary operation:
+By default, all groups will be OR'ed together. If a group has one of
+the prefixes **&**, **^**, or **~**, it will be combined with the
+resulting mask using a different binary operation:
 
-**&**__<MASK_OR_LIST>__::
-The group will be combined with a binary AND operation. I.e. all bits that are
-set to 1 in the group AND the combined groups so far will be preserved to 1.
-All other bits will be reset to 0.
+**&**__mask__|**&**__list__::
+The group will be combined with a binary AND operation.
+That is: all bits that are set to 1 in the group AND in the combined groups
+so far will be preserved as 1. All other bits will be reset to 0.
 
-**^**__<MASK_OR_LIST>__::
-The group will be combined with a binary XOR operation. I.e. all bits that are
-set to 1 in the group AND to 0 the combined groups so far (or the other way
-around) will be set to 1. Bits that are both to 1 or both to 0 will be reset to
-0.
+**^**__mask__|**+++^+++**__list__::
+The group will be combined with a binary XOR operation.
+That is: all bits that are set to 1 in the group AND to 0 in the combined
+groups so far (or the other way around) will be set to 1.
+Bits that are set both to 1 or both to 0 will be reset to 0.
 
-**~**__<MASK_OR_LIST>__::
+**~**__mask__|**+++~+++**__list__::
 All bits set to 1 in the group will be cleared (reset to 0) in the combined
 groups so far.
 
 == OPTIONS
 
-*-w* __<NUM>__, *--width* __<NUM>__::
-Maximum number of bits in the masks handled by *bits* (default __8192__). Any
-bit larger than this number will be truncated.
+*-w* _number_, *--width* _number_::
+The maximum number of bits in the masks handled by *bits*.
+The default is *8192*. Any bit larger than this number will be truncated.
 
 include::man-common/help-version.adoc[]
 
@@ -78,19 +82,19 @@ include::man-common/help-version.adoc[]
 One of the following conversion modes can be specified. If not specified, it
 defaults to *-m*, *--mask*.
 
-*-m*, *--mask*::
-Print the combined args as a hexadecimal mask value (default).
+*-b*, *--binary*::
+Print the combined arguments as a binary mask value.
 
 *-g*, *--grouped-mask*::
-Print the combined args as a hexadecimal mask value in 32bit comma separated
-groups.
-
-*-b*, *--binary*::
-Print the combined args as a binary mask value.
+Print the combined arguments as a hexadecimal mask value
+in 32-bit comma-separated groups.
 
 *-l*, *--list*::
-Print the combined args as a list of bit IDs. Consecutive IDs are compressed as
-ranges.
+Print the combined arguments as a list of bit IDs.
+Consecutive IDs are compressed to ranges.
+
+*-m*, *--mask*::
+Print the combined arguments as a hexadecimal mask value (default).
 
 == EXAMPLES
 
-- 
2.48.1

