Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B233F390
	for <util-linux@vger.kernel.org>; Mon,  8 Jun 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917144; cv=none; b=OKouap02ovh7EB4pNCHiYPSL0QGHsETBeQoQESIvwS2oQwLAjaAdQ2qV5OsRrkcRI4VQj1zXbDCurAViCTNu2tXYhLILE5lvLots5Z0KrJ8/w50p16Vd6yk8HCq68Atg8ZglYC/xINgsoT2slXJsHrU+q4XhVvOdHrlBTC3Wowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917144; c=relaxed/simple;
	bh=yTgVG2RK3pDTUieH3kogO0rGlSDj6c4IMbao+eR7l08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM5cjKqbK8VUKuPaLawC3LNfu+dl9occnVl+W3Emyy1JPc4xTx4votJR1p7NK4s9EoQlcoIE2ZrBS+/953Mmq9urNUYx4y1/aS8IS5YiAi1/zNx7wvOW46N8goBhjGNF7Ry2GrCUI3DY5bZwtyHu/VWcPc9IEeHKwFrSoW8GXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB2cE9bR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB2cE9bR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780917140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py3LHSyRWF59HAJ617l/zDs2L1BoODHr0Leqwm/Qpnw=;
	b=KB2cE9bRcKuWz7lOgZY9k+vHZuhm9yX+njPtmyU0yFvzrrbbJ7w3xaDqGI+b7MsPaRsxd4
	yaelq5Od69vJcT3GCS8IeOA1Q1Ou0R7wUbXqF81jruddLuCc+qENNosZfTvC09Om2uDHxJ
	nAuaoqEoWRzN89bEjXwlar//qPb6Y28=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-1Dh3HZYoMCeV4E9pODtjpQ-1; Mon,
 08 Jun 2026 07:12:17 -0400
X-MC-Unique: 1Dh3HZYoMCeV4E9pODtjpQ-1
X-Mimecast-MFC-AGG-ID: 1Dh3HZYoMCeV4E9pODtjpQ_1780917136
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6AF419560B0;
	Mon,  8 Jun 2026 11:12:15 +0000 (UTC)
Received: from ws (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2F973008B34;
	Mon,  8 Jun 2026 11:12:14 +0000 (UTC)
Date: Mon, 8 Jun 2026 13:12:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] lsmem: (usage) list possible values for <when> like
 for the other <when>
Message-ID: <5zni7ahfvmnhsid7f4we74hrlmga6itznrsjj4sjurydin4sm2@4jqk36onqhgb>
References: <20260604095252.162210-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604095252.162210-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jun 04, 2026 at 11:52:50AM +0200, Benno Schulenberg wrote:
>  sys-utils/lsmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All three patches have been applied. Thank you!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

