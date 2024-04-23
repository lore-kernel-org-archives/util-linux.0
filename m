Received: from lb1.peda.net (lb1.peda.net [130.234.6.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF73136989
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.234.6.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881100; cv=none; b=QQhXpR/ckKxz+g7kNKrLrAwLdJHeVxPj7LV2wFQKxTEIQ6Sn6ozyuQHondDLAjsAqtkLRHeBTf3befLrrby2lSO49Yyr/trRXmaQiOqc/xuQ1NQu0UVGCCMQQnwYAeT5kJT5NU/pv7OWuZX6WXcfpE/tYImanevKpP01/FaqCYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881100; c=relaxed/simple;
	bh=LI9VmtRYCD3D0x1bWauokwtRfkwfcKnCJXSNAx3PP14=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Y0cyeZ19J/Xq4V/WRk5Oq1iHv3rJ8XedEylSybPAy/fJlJZ4pwfEZN88EwMXZ82YWakG9uafUbJ1LvAzjSh6f3DoxgRKXVkzVHe90cKv7vhrPfwkK9T2CMvd2XrXs8zmpeoAYnkzkxYCKoqyVU7myorIoQG+xKuRtHYmXIxN1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peda.net; spf=pass smtp.mailfrom=peda.net; dkim=pass (2048-bit key) header.d=peda.net header.i=@peda.net header.b=sO9cpp+q; arc=none smtp.client-ip=130.234.6.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=peda.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peda.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peda.net header.i=@peda.net header.b="sO9cpp+q"
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
	by lb1.peda.net (lb1.peda.net) with ESMTPSA id C8816600005;
	Tue, 23 Apr 2024 16:58:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=peda.net; s=default;
	t=1713880690; bh=LI9VmtRYCD3D0x1bWauokwtRfkwfcKnCJXSNAx3PP14=;
	h=Date:To:From:Subject:From;
	b=sO9cpp+qKG7UnTJUiTt80mp7o8DdMsOWe+QgCcEWJoD9QHNhUf5e+kUPosmGiy2G1
	 eLr+XO937pTL9PeJQqQOqIH+QnQDYDFSXpV3m7klEdWfzoPDof/qb8T0IyZRMdJe6c
	 5iX/ayw1V8hsBKpOIhcXeIt4LIK+geTwHkoRlUg+lhLnk4eH7wi9+EOqDpsBso+Qy0
	 9oWktf9lSTYkSOeH/Uy6yt1mN2keN0d1MoEod1ZVVJFjJI4IFgN20EGV3FsiTM0Kxv
	 0rwpLHeiWvD+AvvxsvCnazFQ2H7oNytcIoeUe8ZZLmiFnbS90FCL0HrxV3Q+rKfml3
	 h+LaHXDpHXfaA==
Message-ID: <0aa615c2-8e17-4eb3-9a25-c8af39b35d81@peda.net>
Date: Tue, 23 Apr 2024 16:58:10 +0300
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: util-linux@vger.kernel.org
From: Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: RFE: hardlink: support specifying max_size too?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I have huge directory hierarchies that I would like to run hardlink
against but comparing a lot of files against each other results in high
RAM usage because so much of the file metadata is kept in memory.

Could you add max_size (--maximum-size) option in addition to min_size
(--minimum-size)? This would allow splitting the work into small
fragments where hardlink only needs to process files in given range and
immediately ignore all other files. Or it could be used to run full
linking in multiple parallel tasks with sensible RAM requirements if you
can run hardlink without size limitations (e.g. one task for 1–1MB
files, another for 1MB–10MB and third task for files bigger than 10MB).

It might also make sense to reorder the test for filesize and regex
processing in inserter() because testing for size is probably faster
because the stat() has already been made. Currently the stats.files is
also increased for files that get ignored by size filter which may not
be intentional.

I think I could provide patches if I just know which Git repo I should
use as the basis. Is https://github.com/util-linux/util-linux the
correct one?

-- 
Mikko

