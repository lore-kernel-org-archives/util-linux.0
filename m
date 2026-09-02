Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AC47B436
	for <util-linux@vger.kernel.org>; Wed,  2 Sep 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349601; cv=none; b=b477hdhsBeQkCNOdVvNFV6hQ/AzmPiQHD/qNuZuBjM2lYIf310OalPDLGWH1MOme9SjZn6Mhf/nWnKieToYvITzXipvUKBkSKa3p46bCR9rzRMpzzuY9xsgB+sizoTTdyrecCIZyBp4SQNNngKxZ1Mb6fdK6EGn2n+4ims/NaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349601; c=relaxed/simple;
	bh=HgzVyy7Q5snPcm8XgceJF56h8tdZf5PK9WFuk+OujuQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mL/VeKxldzFmOTgfGOte1RH0jzzSVtzNQSp2UX9n1L9h41SIC83eGzvDdBt9SYe3Dg1HD17yCG3JDHyjj7B/ExywBbud3Y7XwHkKt5U37lo0GgofWNGI/L0nvAYX9rk9xiwP0CVwKSKYdiyakCgcGUcN9jSyKfBnk47MU1oTDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gf+LhieV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf+LhieV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788349595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEM2MUJG36vAS4P4vLhhlcB0L+nHE/naVLqX4pcdEdA=;
	b=Gf+LhieVrZi72ICx43XEnTOOe1nkJrlINjPp+pUVDSt8XvjRjj9vHXXAayhnncLOaCUj1w
	/EQxUMKFsB4/tJiQUiHqbF928PwWu6j44vxObam6lrIG3zRRhvWP8mPW9pIz/NcOu8XtVt
	Oe5Ft9tBePDueLz7CMqVsFgH3lAUYIQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-iqj010ljPC6O6ThCzvROhw-1; Wed,
 02 Sept 2026 07:46:34 -0400
X-MC-Unique: iqj010ljPC6O6ThCzvROhw-1
X-Mimecast-MFC-AGG-ID: iqj010ljPC6O6ThCzvROhw_1788349593
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3346B1977539
	for <util-linux@vger.kernel.org>; Wed,  2 Sep 2026 11:46:33 +0000 (UTC)
Received: from ws (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C5353000223
	for <util-linux@vger.kernel.org>; Wed,  2 Sep 2026 11:46:31 +0000 (UTC)
Date: Wed, 2 Sep 2026 13:46:28 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: util-linux v2.41.6 / v2.42.3: build failure on some distributions
Message-ID: <gwgj462ab2hg4snjfl2ayoedgwrdhejfji65xu6tqw2vaqjvtx@svowjpc4mg5z>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


Hi,

The latest util-linux security releases may fail to build on
distributions where glibc does not transitively include
<linux/openat2.h> through <fcntl.h> (notably Ubuntu, Debian, and
older glibc in general).

The error is:

    libmount/src/hook_idmap.c:335:33: error: 'RESOLVE_NO_SYMLINKS' undeclared

The file uses the RESOLVE_NO_SYMLINKS constant but is missing
#include "fileutils.h", which provides a fallback definition. The
build succeeds on Fedora (glibc 2.40+) because its glibc headers
happen to pull in <linux/openat2.h> indirectly, masking the issue.

The fix is a one-line include addition. Patches are available:

- master:       https://github.com/util-linux/util-linux/commit/7e2e01087
- stable/v2.42: https://github.com/util-linux/util-linux/commit/a323dddbc
- stable/v2.41: https://github.com/util-linux/util-linux/commit/79c2881c2


Sorry about that — the security patches were released under embargo
without a full CI run, which would have caught this. I'll make sure
to run CI before tagging future security releases as well. 

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

