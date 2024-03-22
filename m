Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A836AF3
	for <util-linux@vger.kernel.org>; Fri, 22 Mar 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103008; cv=none; b=AIt/MfHPmp5iIsyUi92/CJVOA8Iy46Q6haXp8fg812ECo/rwIpQWjEMallnQyR3IBdcfqDzUsqwz3rHXA9xVyVN79tUnhTR44jfRLChZItWSfvZPVP0UpIUERfMLKP1jMm2EkRQjXD2spQ3xUwrpC0dNykN3QXCp0y3y9TSR0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103008; c=relaxed/simple;
	bh=Xp3G505lVPhSlAEujU7v06k92hEUnGrpFAIAA1poZ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpcTTGNrKFBaqXjmUttH+x9RsiT5rFdXUBGAP2UnvPxSR4iENM5qgpVNUvnlzd46uDsYgweNBRKBvb6eVjKF90AdVImtC+IH/+EY7T7NopMPoof+g4hJC/8zjOYHN0SlF5CjLS11kD7Hl89RMHY2YdQphnFwa+5G+rlY2vGfAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPzD3L9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPzD3L9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711103005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5sPM2Batsn22gB3Xn2YlCAHaTr6jCqx4AgiquccGOk=;
	b=gPzD3L9BX2VcMiC+zgwIl6ZHYs0fpvuPOUDQPn8UFem9oOjhVtGxCnmlA1Ju6lTZz++o9p
	UJtFbjphkuL5E4v8fFgyuIjHDhrcCMqyHzT7oCWwoTVmzZMENdyiTRTKmTQK1Wy47VphzC
	wV90BcZS1V9qmjztV5Y91Bhm3s1KBNo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-cC8vSq0wM1agWRa1YyRg3A-1; Fri,
 22 Mar 2024 06:23:22 -0400
X-MC-Unique: cC8vSq0wM1agWRa1YyRg3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1BE12801584;
	Fri, 22 Mar 2024 10:23:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.242.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D8FCB4073598;
	Fri, 22 Mar 2024 10:23:19 +0000 (UTC)
Date: Fri, 22 Mar 2024 11:22:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Paul Eggert <eggert@cs.ucla.edu>,
	=?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>,
	69532@debbugs.gnu.org, util-linux <util-linux@vger.kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Petr Malat <oss@malat.biz>, Rob Landley <rob@landley.net>
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Message-ID: <20240322102257.ovv5kpnm4zsgtf7n@ws.net.home>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
 <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
 <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Mar 20, 2024 at 11:53:05PM +0100, Bernhard Voelker wrote:
> On userland OTOH, we have broader choice.
> Karel did his choice in util-linux for exch(1), and coreutils could expose
> the same functionality.
> 
> For other feature requests, we were much more reluctant in coreutils ... for
> good reasons: feature bloat, maintainability, etc.
> 
> So I'm asking myself what is different this time?
> - The feature already exists -> util-linux.

Note that we can move exch(1) from util-linux to coreutils if, at the
end of the brainstorming session, the conclusion will be that mv(1) is
a bad choice :-)

> I'm currently only 20:80 for adding it to mv(1).

I think the functionality will be lost in the mv(1) for many users.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

