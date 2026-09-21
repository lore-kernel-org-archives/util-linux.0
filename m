Received: from out-zbxj-a78.jellyfish.systems (out-zbxj-a78.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36C3E51DE
	for <util-linux@vger.kernel.org>; Mon, 21 Sep 2026 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976310; cv=none; b=bGAUOzbCve4RvRm+375gRwtHMm/yYlZMdNWCRiko74ZTx5oA87cWhccp4lJ/jQ0XXqPc2wjM9ntg4DKtZRQk1EP4q31ycdWrGlFt/15RWtxH5gVfJkb5/hn1HPCKqAC9U0J2CyRlSZGwyA/vN8v3+dT5PuVHYEBaQO4mywsHnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976310; c=relaxed/simple;
	bh=D2c7u44XdNWk6RoQ2ot2lK9egnX7X4qCtgpL06kqiZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGi/Y1hHUp8Ya4uoHq8UePFzwzCFm1Cf6CPDEyowq1+72NayYnVIxS1XdWJaRprz2+THedQTH/rM9UHKmNhj9SnJqWMG3SS7BZYtzs2Th9cQ5mEa3ljFO2HKnlPPyjDsQ/jFTWlbynHhjSLWlrBY19nn9b5m3Knozl11hDfbJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=UvtfpvL5; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="UvtfpvL5"
Received: from [172.20.10.14] (unknown [117.136.111.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hpFSn4JFqz2x9p;
	Mon, 21 Sep 2026 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789976282;
	bh=D2c7u44XdNWk6RoQ2ot2lK9egnX7X4qCtgpL06kqiZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvtfpvL5QcRprUUDeTNP0sEw2R6Izlq7mbVMXcM4rKVf2Qd0n/hs9YJH1ShjC7VPI
	 2qHBc8LogAG41tsVyfEwiiJoziXNE3OSQxS0wZ3/OsQ2Hcoy6wbpd3eNEcEVrUE65N
	 vf3HevJjpAEgzzDWH2BCRIhC6XXpcRM1S/AqxDoAOKJXmPvuzsICNogD7u9HxYRSLS
	 wbBVce7BiphuLvjBESTgrXIcw9Jb4LVrVHxoxcWx1qVK/J6pNGYu8Qo1iSq0MPblJH
	 NHthRTPWhiyFEWpfTu6W2rg4Jsm2ufECpbDT5xQH6uPi2+rGI3iTB435/F4ZzomvdQ
	 Le7Gqzb75ZseQ==
From: Tianyi Chen <hi@tychen.cc>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] libmount: explicit loop direct I/O requests
Date: Mon, 21 Sep 2026 16:37:58 +0900
Message-ID: <178997627856.100831.15330580858616295838@tychen.cc>
In-Reply-To: <zxpnm3dbgy6vv64gockhcl5egfpe2qpld7jlkgg3enr5jbfha2@q27vjqxnocmb>
References: <178981850377.1262776.17938790502420524863@tychen.cc>
 <zxpnm3dbgy6vv64gockhcl5egfpe2qpld7jlkgg3enr5jbfha2@q27vjqxnocmb>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Envelope-From: hi@tychen.cc

Hi Karel,

> loopcxt_setup_device() should be ready; we just need to ensure that
> the flags match on loopdev reuse.

Agreed. The patch uses the existing setup path without new-device
readback, and checks explicit on/off requests when reusing a device.
Failure cleanup also leaves reused devices attached.

Sent as a new thread:
https://lore.kernel.org/r/20260921073613.99690-1-hi@tychen.cc

The new direct-I/O test and existing regfile and fstab-loop tests pass.

Thanks,
Tianyi
