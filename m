Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC2159209
	for <util-linux@vger.kernel.org>; Wed, 24 Apr 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953743; cv=none; b=bzY+618J6vC1zBNG4hBkypewd7qDV3FPgwiBmdFKMtM5/bSXxdzhAIcJOfYb/DhfNpE41xWaSV7SYMB4obzNWjOIu0OgbQis4YGx/OpwaRlV26scssr3F1eArGOrfQj+YUbus7pqsXa1GekrSiZt23YvpEFWTJIc/Riy7xM0oe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953743; c=relaxed/simple;
	bh=/kE+ZnhDvNwHM3D5tciZFVA9jYiCUJLGlLiHAU6B6zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9ZYl6E9MNLVZXrtiaIl2VgRzlvRIEhAtWokrUxS2d49G4wInM/GyTNAeytjI//8WqZsrWgQGk8MMfU75/Ryqpt6mgJTmJ+TSG/esjoO87g1VeWNy0ulrJTR+5dQTcchfxRUFJ2chxJerB4yyr2xmdAUUwnlNpeC4+LOprRzMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI1h66if; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI1h66if"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713953740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dj2Me5j1k8DMPIlQiprv1zongFHmLzA1sJ4KM/81AjQ=;
	b=KI1h66ifCza4aBaZCo8Da/ZEH9l+34Q1lQYiegBOQyy+np1fhRkKDEsUtwa7gXGs/rkYXy
	vg2CCVspMcCWu3BJlKJv4fZ0T4L3GOl33zTb0K4U4SJxxNRv8cnf85n+XQyppswsvbZ0K9
	WIzR8Vv/SNGvoiCRKl33VQ5iq9VWuaQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-xRS-WHneOkeCqya9E_Sd2g-1; Wed,
 24 Apr 2024 06:15:38 -0400
X-MC-Unique: xRS-WHneOkeCqya9E_Sd2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27D661C3F0F4;
	Wed, 24 Apr 2024 10:15:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A3BB410FCEE2;
	Wed, 24 Apr 2024 10:15:37 +0000 (UTC)
Date: Wed, 24 Apr 2024 12:15:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: umount -r broken due to "mountinfo unnecessary"
Message-ID: <20240424101535.4tvyms63egfwlw46@ws.net.home>
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
 <20240423083358.2k532xl557meewws@ws.net.home>
 <1350349b-8465-4ce6-8dc9-55a32b84dc39@ans.pl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1350349b-8465-4ce6-8dc9-55a32b84dc39@ans.pl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Apr 23, 2024 at 07:35:18AM -0700, Krzysztof Olędzki wrote:
> When is the next release planned?

I plan to release v2.40.1 next week.

> Also, do you expect a backport to stable/v2.39 and v2.39.5?

I have cherry-picked it to stable/v2.39. Currently, I have no plans
for v2.39.5.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

