Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED133256C7C
	for <util-linux@vger.kernel.org>; Wed, 30 Jul 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863799; cv=none; b=ag0bmaU4Lgcgya5uZadHJje8l2Bjk/BliaEq1aCpUmWWWtnaQHI4/ZI9eAlyBR1I4Bc+NfD4ZsAQY1sEm4ysuYNu0WrXkqIBQJ2wIlzbdd0NDsPWlux7y2zInAY8MFCmq5U79GlQ9FS41OU9bVrRAEiFH5Ww0UyX8GIZdH8nCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863799; c=relaxed/simple;
	bh=4+QbMXix61Mj/kTJyil31QGyZo30SppEBqBnsb7AcVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4T4RGBaiCyp0VA3pg6/zIGO3BwUu8bugRb0TBb82ueU0DPZo9Ot0lGUnPUV/AiY/mSwLRjDd4z3HwnDRdvEB2TTuTEcRCUmlD8PKEQcTJdF+en/5h36EmVPeLPcdmUSln9ebXfEcBqlFit4MVhy7HcVfqtYKvtw+X00me4kKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7of74KZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7of74KZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753863793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2VrzFLO7RNu9HbSSNx8zEdlBE87ly+5bLwdvQdHhGo=;
	b=W7of74KZEeNChl4DQMiwA0Fcf/d+Bg8GmQWyHBSAGHU/moSpmbTFPSXEhvXRyBgcDS7KNN
	WOsl3pwNBFwtmXIKQxaSccu7JMMCaAkWGsZQHGBpyd/m+AHMTruBFCvifcu71vabKck05B
	vPO7dQAHSJm6vUn/Jt8rpcA80brdfo8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-jRQHskmvMYO_gqaHJoxChQ-1; Wed,
 30 Jul 2025 04:23:11 -0400
X-MC-Unique: jRQHskmvMYO_gqaHJoxChQ-1
X-Mimecast-MFC-AGG-ID: jRQHskmvMYO_gqaHJoxChQ_1753863790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FDF21800446;
	Wed, 30 Jul 2025 08:23:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27C4C30001B1;
	Wed, 30 Jul 2025 08:23:07 +0000 (UTC)
Date: Wed, 30 Jul 2025 10:23:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: util-linux@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: [PATCH v2] chrt: Allow optional priority for =?utf-8?Q?non?=
 =?utf-8?B?4oCRcHJpbw==?= policies without --pid
Message-ID: <froj2nyx5yj7kmkmcksfbnwnfnvmzqcrxtatvvedtkwojxv4q2@hkm5zkikdxhr>
References: <20250729094703.62408-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729094703.62408-1-vineethr@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jul 29, 2025 at 03:17:03PM +0530, Madadi Vineeth Reddy wrote:
>  schedutils/chrt.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

