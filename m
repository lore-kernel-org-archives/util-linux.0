Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6B53E23
	for <util-linux@vger.kernel.org>; Fri, 31 Jan 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738293578; cv=none; b=Ne6kvNxX3Z8FQ2pcrEbbyODzUt73iuzw5mULtgNWr2sct7e/aMMp4Bzw8WTtZVXowRWBdnLiRbPODvCV5PJxQZ81vuLVN67jczgBfnihb83JQzKcK4lYx+Y5BARlHN/HEA+Wq9753vD0pm41R7GpV59tc2pSBlElikaxHwqmvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738293578; c=relaxed/simple;
	bh=BsqY4hv2svBJwF1yUKSPoHpPUUNUuy0D3DteQRUyl7A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kdevrBkJyIG+pKws7vhj3cRQ4kHJ4ZkhS9XkndgMhxr4iBzG0GkN+v91CmMLWG99jib6uCyzWgHYPk6QlDJq1l3KcjjP6wEkuKgMLDwuAZwm0QtNkZhQu45VimXX/hn+6TcHmPe/wxdPbrM+X6JLF2d7gKqzw3WakcOyyHXeqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=La7j88Ox; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="La7j88Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738293577; x=1769829577;
  h=from:to:cc:subject:date:message-id;
  bh=BsqY4hv2svBJwF1yUKSPoHpPUUNUuy0D3DteQRUyl7A=;
  b=La7j88OxTNRDoyCOy6OI2epxgH1DH7q+8Thzs6vv7ye9a+6tiXTy/nkZ
   hb1oYneip2CfXkVsTG9XMeyMM5EgzF/t67dX3NVXVl8iP/BqXZz+nPQs5
   hvmF2F0Eqgw6fCT1vP3PCAF4zVya1/xKT1VUgT7HpOlw2rKLm1Udwfjq8
   0wgWA2o+ihFlHGfTCV6kMHwO21Cx69MQGQ+phnqL/knX4wi2vUnwJdWlP
   5hQ4u7fW+/I8sc0R8pY+eDzScjk5COfMCeNrX/wNcupCwPs2FyxFynIdQ
   L4DiYn99zp3PYiXUBcplzAeNNx5zV5jqJKUi0YocPp06dlw49cVoLjQS6
   Q==;
X-CSE-ConnectionGUID: 3SRp/gQ3Sv6lg7tv3eG39Q==
X-CSE-MsgGUID: ssxkSkUoT5KqmuLxio4RIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="42613688"
X-IronPort-AV: E=Sophos;i="6.13,247,1732608000"; 
   d="scan'208";a="42613688"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 19:19:36 -0800
X-CSE-ConnectionGUID: YSMY07gdRtaUug9vbyWxbA==
X-CSE-MsgGUID: iHx75YB5QYCntQ34PXr4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114127531"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jan 2025 19:19:36 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: util-linux@vger.kernel.org
Cc: Ricardo Neri <ricardo.neri@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH] lscpu: skip frequencies of 0 MHz when getting minmhz
Date: Thu, 30 Jan 2025 19:25:32 -0800
Message-Id: <20250131032532.17492-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

read_mhz() sets cpu->mhz_min_freq from /sys/devices/system/cpu/cpuN/
cpufreq/cpuinfo_min_freq. The file read fails if cpuN is offline and
cpu->mhz_min_freq is left as 0. 0 MHz is treated as invalid frequency.

lsblk_cputype_get_minmhz() iterates through all possible CPUs to find the
minimum frequency. If one or more CPUs are offline, the minimum frequency
will be 0. This is reflected in the output of lscpu:

	$ ./lscpu | grep min
	CPU min MHz:                        0.0000

Ignore 0-MHz frequencies to find the actual minimum frequency:

	$ ./lscpu | grep min
	CPU min MHz:                     1200.0000

Reported-by: Thangamani Krishnan <thangamani.krishnan@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 sys-utils/lscpu-topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/lscpu-topology.c b/sys-utils/lscpu-topology.c
index 547a3aca0..36a217bc7 100644
--- a/sys-utils/lscpu-topology.c
+++ b/sys-utils/lscpu-topology.c
@@ -660,6 +660,8 @@ float lsblk_cputype_get_minmhz(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 
 		if (!cpu || cpu->type != ct || !is_cpu_present(cxt, cpu))
 			continue;
+		if (!cpu->mhz_min_freq)
+			continue;
 		if (res < 0.0 || cpu->mhz_min_freq < res)
 			res = cpu->mhz_min_freq;
 	}
-- 
2.34.1

