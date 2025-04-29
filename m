Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E129DB7C
	for <util-linux@vger.kernel.org>; Tue, 29 Apr 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925109; cv=none; b=HWUqHGiY3Ja6DUIXp452d2FwJQzHsZVTS7B1mb5d7pMkXGvNpqwPImubg+BWj9Vt/jWmA7RmRThVeaJLRG2d4p/C9uakm9dqlbPFntlbncofc2lfVNorGdc/xMMUhv9iRwIt3GVFHZqoa0XAkB82ZdsXLu1UpPSWk7gYsuI7mhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925109; c=relaxed/simple;
	bh=a0Jofv7FR52gX2bl+JDGPdUc6Rql8MvLjz2QCYkrdno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ5iRqfZ0mnsrDEkPyzMYSjKN0g0nY8rXM7DSlCBTBJe+bqIIUemRhjJtpRq4OqNK/39abUO7hgRI5h9WqGlPHyVxO9dDrcKDr0hQ929Rmb4A1hAqJ/woxXgKbvOLv3O8I/stgb6CD8Qh/0UUSg0+Ma65OIXpYvhuDRcCoPvtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGfx7Ygx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGfx7Ygx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745925106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RlS7lqqi6ZrR6Ha/bzEoGkV1uFjokJtzNy3Mm5Smzc=;
	b=KGfx7YgxOg/fbe73V3Sq9qYJHEUwS9jgqTb2xeylR5VOWjuwbITdfztVrackUXETFnGYmn
	FmjjhEJfZ5EIA3STvpgxh6RfEvLHNvAvXUHEcTGHUX3NHes0/PK7cE67iuFTlwkb+XvxCP
	vvrFBDGIkHMkPg0su6aIr65eZyvJ16g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-Fx_EJuPgPb6m8938XsrQdw-1; Tue,
 29 Apr 2025 07:11:43 -0400
X-MC-Unique: Fx_EJuPgPb6m8938XsrQdw-1
X-Mimecast-MFC-AGG-ID: Fx_EJuPgPb6m8938XsrQdw_1745925102
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4AB51800370;
	Tue, 29 Apr 2025 11:11:41 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.63])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B9319560A3;
	Tue, 29 Apr 2025 11:11:40 +0000 (UTC)
Date: Tue, 29 Apr 2025 13:11:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] unshare: make the wording of a message identical to
 that of three others
Message-ID: <qf3xkiasm5b5zliten36bjv4ynd4kdzj7nll5x3nq5jsasfegg@evnsrxot4x6j>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


Created a pull request at
https://github.com/util-linux/util-linux/pull/3550 to test the patches
via CI. I hope I have applied the correct versions of the patches :)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

