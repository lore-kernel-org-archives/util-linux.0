Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97F6FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089580; cv=none; b=QZsxDlcnSHA6Vcmyv+zqoCoiEj0YTLesfQbf2I8o3Cuua3Jy9JggmxPxXS5YgqTRh00HJu6VE3BuHNJxHlz3P1UPoRC+0/jF1Ud744LytQ+D2eexBhbmVQQ/sIVplffh3mC8LyJTGBxCT3sJjcx5g57/eo2Ao1Zfs+SvBHc3Y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089580; c=relaxed/simple;
	bh=q08OuB1qqOZqhafGOttykUEqK8ZwCEGfl+2k+tsMuu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGJWw2pyKV/lxyZ+aFfrTZLD6GPpy+kRlfyd1jKgKY/IgPuKv0SA75MrECqb1s0WaHqT2AQY22quiZEDDaH8TF5Gq2cex/FFQiuwv5FeB8zcbnvbaXE/duCnMNE3apN4c6HGzOzNAVmF2Nw2liA4ulVlVK5dGz8srT4AxDk8F2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=AQ6qM+9L; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="AQ6qM+9L"
X-KPN-MessageId: b8921d47-e6bf-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b8921d47-e6bf-11ef-8d8a-005056aba152;
	Sun, 09 Feb 2025 09:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=c8thfvFsNmgUUwWHxmyceivZROwkeXkugRKh9tVcVYk=;
	b=AQ6qM+9LQqPawsD0BsYqenkFfhKvN24ml/L19nhC6Oya5REwc6xCNnSDst3n4vcyB9z+9zBgNlQz/
	 3L3Z1QsYVoGSVBGfzIr9qVBSAiK7kC0Fcq/7r6Fx/acApZP77V+mpATtTaUzHBes8TPeAQXtXbFMdc
	 lU2tSPcEImF2eZIQ=
X-KPN-MID: 33|9zDt0PKtk7YAUgH75o1EIkpYbyS4TfEpUyoBBt6lN+nxEzgMde6qUeGgKlfVGdF
 0rSTy5gnwtrWbyOtrpK8M61QSihtYUqqD4ejo5QdRWa4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jZvMe3jBexqQ6DzYkQNL94oxa6yuuDvgZZPklBi63suY4iG5HiQ+SmDHG9C1EyF
 TRpe9Y50tEkfq7x9uAuU2Rg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8834f576-e6bf-11ef-9a03-005056ab1411;
	Sun, 09 Feb 2025 09:26:17 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 13/14] usage: mention also the missing KiB and MiB as permissible suffixes
Date: Sun,  9 Feb 2025 09:23:29 +0100
Message-ID: <20250209082330.4235-13-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, slightly reword the phrase to be more grammatical,
and make it into a full sentence that ends in a period.

(By the way, commit f1970cc557 is somewhat problematic: it requires
that the relevant occurrences of "<num>" and "<size>" in the option
descriptions are now always translated in the same manner, but the
translator may be unaware of this.  For Dutch, the latter was the
case for `ipcmk` and `zramctl`. :/ )

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 include/c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/c.h b/include/c.h
index ec2d32c38..dcb2d683c 100644
--- a/include/c.h
+++ b/include/c.h
@@ -474,8 +474,8 @@ static inline void __attribute__((__noreturn__)) ul_sig_err(int excode, const ch
 
 #define USAGE_ARG_SEPARATOR    "\n"
 #define USAGE_ARG_SIZE(_name) \
-		_(" %s arguments may be followed by the suffixes for\n" \
-		  "   GiB, TiB, PiB, EiB, ZiB, and YiB (the \"iB\" is optional)\n"), _name
+		_(" Values for %s may be followed by a suffix: KiB, MiB,\n" \
+		  " GiB, TiB, PiB, EiB, ZiB, or YiB (where the \"iB\" is optional).\n"), _name
 
 #define USAGE_MAN_TAIL(_man)   _("\nFor more details see %s.\n"), _man
 
-- 
2.48.1

