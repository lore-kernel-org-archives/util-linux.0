Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BC3A1C9
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726907445; cv=none; b=CfiflVnbxn5sbWDHt277LQtaz+kE++Nh4KBJvwhIKOIwnFhoZQe6OCaO3LI9C8KVUe4mfFbq1O0YR1+6DIdgroP9ramgchFRFrwKj8VtR9MB18p62AUD19DSXxCv4O4bZv94SBctwxZ0MyUUkMnztxlcXZR8qkdcrDF0Yh0m8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726907445; c=relaxed/simple;
	bh=j0qh8mSORFflzzSBNnZNgk19O0mAEuKfAjX9BFt9Fq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qVQCD2Ky6JUiqZ4GGtZUrmn1A7ndxmI95rU6+8+xnYEuFHV6qECazXWD+Kve3+1TAsmXaZrAzesYp1WQIM0hmYkdQhYweA5pDCPtYv8s6iO3qU4fAVv8y3cdzgJ3t7qiovEDwds/GsPWA78yosUZ9s4n59IIuIRaTbsm0DP8Hko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se; spf=pass smtp.mailfrom=lxm.se; dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b=HEuhQ5Uh; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lxm.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b="HEuhQ5Uh"
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 6A52688F59
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
Received: from s980.loopia.se (unknown [172.22.191.5])
	by s807.loopia.se (Postfix) with ESMTP id 5C3A48C3EB
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
Received: from s473.loopia.se (unknown [172.22.191.6])
	by s980.loopia.se (Postfix) with ESMTP id 5B3812201692
	for <util-linux@vger.kernel.org>; Sat, 21 Sep 2024 10:24:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s473.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=lxm.se
Received: from s980.loopia.se ([172.22.191.6])
 by s473.loopia.se (s473.loopia.se [172.22.190.13]) (amavisd-new, port 10024)
 with LMTP id Z7tV4HR_eaZH; Sat, 21 Sep 2024 10:24:41 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: henrik@lxm.se
X-Loopia-Originating-IP: 92.35.23.126
Received: from pc.arpa.home (c-7e17235c.012-196-6c6b701.bbcust.telenor.se [92.35.23.126])
	(Authenticated sender: henrik@lxm.se)
	by s980.loopia.se (Postfix) with ESMTPSA id ADCE522015EE;
	Sat, 21 Sep 2024 10:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxm.se;
	s=loopiadkim1708025221; t=1726907080;
	bh=AyRlLdCYcXO6BTfMZmLo9Pmup74VVc7Ort253cTa0+8=;
	h=From:To:Cc:Subject:Date;
	b=HEuhQ5UhRkfU/9ZsMAR49JWXo7isA4FKxnK37w/T739oWcnBJvnt1+zn0iUi0clZ6
	 l3+//SHkuKrg98ZVZfJ2igs0BSdOahRc3vA0iihpv47ukywJbUFZFi1f6aHy/pv9U8
	 T8LNysOTyvLl/gcnbgchLRIw34GqkU2g2dxiU6Tx0esxCZfDxKRqBRLKegER5NvPOP
	 UGaBt3LFTpBAVOUC9+FQlIPxDxZ2HUUAgjkIadhbzVGsetXhmh+fryQlJx1IeMMptl
	 qrW2RlohL6kZbYDZps49gSCCHGYx14Q/6HtDSO4SX2//FSRvWMpwBqy7s9LA1l36RM
	 d89rHtjPdOoAw==
From: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
Subject: [PATCH 0/2] Add options to enable building lsblk and dmesg
Date: Sat, 21 Sep 2024 10:23:08 +0200
Message-Id: <20240921082310.232867-1-henrik@lxm.se>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using --disable-all-programs, it was not possible to build lsblk or
dmesg since no configure arguments existed for enabling them.

Henrik Lindström (2):
  lsblk: allow enabling with --disable-all-programs
  dmesg: allow enabling with --disable-all-programs

 configure.ac | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.39.5

