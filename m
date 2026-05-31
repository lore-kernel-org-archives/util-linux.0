Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB512231A23
	for <util-linux@vger.kernel.org>; Sun, 31 May 2026 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257372; cv=none; b=BD4LXhijWfrOZ+XWh6DDd0u8NHSLm1K6GcYYzd9RJfffjevTiifL8/4fawRiwKmH1TKVUwipXP+ygRXptJ/hnnlyFuSadjlxierC/JeXaQVv0tscJZBqLD/mODTQABxQNU3FMhmpGnNBsK47KGMgb56REvfHX4d73BOE62ustww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257372; c=relaxed/simple;
	bh=S0MguQ8Kb8tkXzVUig/Bbcf6m5KLJOKWxJmQQs/lmb4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uE+TsZ0iljXChu5NEiwXC0vo3q2/5Nt98dWpGYU+nxXAp43x4boH/3XBvt5TqDD4pgd3k8wBa5G7Ltwr9FdNgxnwOuJfY+TMUbbK83YaQWMcBdMjVBUrTkd7Gf7c504FZ4VriuLkbBvlkQoNTHbC3Jhbfkc6GzjfuHDs6uLYwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=Jy9SqzAW; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="Jy9SqzAW"
Received: from localhost (unknown [IPv6:2a0c:e303:0:cc00:ba0f:ae98:a175:1ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 53D2560246
	for <util-linux@vger.kernel.org>; Sun, 31 May 2026 21:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1780256816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ikMwGwrMwlc9U+7Y5TNbQM0x35NdJu//rewxzmT79LU=;
	b=Jy9SqzAWzre+vUeQPsV3tU94Xc1xVFdRMcUKVM2/O5akY8PKPlRsHaakpOSevu3OYyneh9
	RoMEHYqJgn3kdR7BoPVp/OneLkWHydtaDhZMGU7fPPuS2VpBYDwgzMi4OLTAHBI842MVb8
	gxMEVRi85MP5GYco7b9Dsb8uPrg9LH8QJQO6bnJk7EBxsrwBepFYl85XAEcECKwRmvAVk8
	bpCRn4gAODwrYU5ehA5JsHG/89Sk9iME29lQvBYKlKXHZSkkw10/6FEm8hdFa9dEsL95ag
	o15IybUL60q/2dCoAtK6rBBQeJMcDHwlOc+7G4QjvUXqfo/74ZNIkQJrxf8Jbg==
Date: Sun, 31 May 2026 21:46:45 +0200
From: Max Gautier <mg@max.gautier.name>
To: util-linux@vger.kernel.org
Subject: Question: GPT GUID for dm-integrity separate metadata partition
Message-ID: <ahyQJUrpRIJY7JfR@framework>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Some context:
When using dm-integrity in Linux (device mapper target to provides
transparent data integrity protection), one has a the option to use a
separate device to store the integrity protection, (which can supposedly
help offset the performance penalty on dm-integry by using a nvme for
HDDs).

While setting up my system (new RAID array on top of dm-integrity on
each RAID member), I asked myself what GPT type those separate integrity
partition should have, to avoid being confused as something else by
other tooling.
(for example systemd auto-mount some partition type, so I suppose some
other tooling could have similar behavior)

I considered 'Linux filesystem' and 'Linux reserved', but the first is
not accurate and I could not find info on the second, so I do not know
if it's reserved for future use (would seem odd seems GUID are
plentiful) or for setup where we just don't want tooling to touch it ?

I don't think Linux RAID is accurate either, (that would be the
partition on the data disks instead).

What's the recommendation when creating a partition not fitting any of
the existing documented GUID ?


Thanks.


(In case this makes matter clearer, here is my intended setup):

# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
NAME        MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
# Those are the raid disk with the data
sda           8:0    0 14.6T  0 disk  
└─sda1        8:1    0 14.6T  0 part  
sdb           8:16   0 14.6T  0 disk  
└─sdb1        8:17   0 14.6T  0 part  
sdc           8:32   0 14.6T  0 disk  
└─sdc1        8:33   0 14.6T  0 part  
nvme0n1     259:0    0  1.8T  0 disk  
├─nvme0n1p1 259:1    0    4G  0 part  
├─nvme0n1p2 259:2    0  150G  0 part  
│ └─root    253:0    0  150G  0 crypt /
│ # Those are the separate integrity partition (not sure exactly how
│   much space I need for now)
├─nvme0n1p3 259:3    0  ???G  0 part  
├─nvme0n1p4 259:4    0  ???G  0 part  
└─nvme0n1p5 259:5    0  ???G  0 part  


-- 
Max Gautier
