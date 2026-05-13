Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B73F7AA8
	for <util-linux@vger.kernel.org>; Wed, 13 May 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669822; cv=none; b=crGXKHa0HsrlA4E1aWYgw9+bER8fIgsuWqf4O7QdvRaWkmHo40IxtgBflsT9TjnbU98rdpOluSdzDVpjCTR44B8TqWGTGke8SI8HNKoAqhVPVIgiTE1ivSaSBBanyBxNQmpdwI7u4vfSB+THQzLe8735XB7Bp9lV3znDPfQ3kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669822; c=relaxed/simple;
	bh=oZD5HsdwYI+6ABO4JyHHsdP6tlKNzNF239xczz7P4gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZheEeeaxEr2MfoLaxc+yYFLHlVJ5Q/3JGe6Tz9uwjV2vEXfyF0oasyc6FSwr23pUyGFmbHA8EFtdo1JQjCxYqyYnnUf+NSN7Xln0JdqVw4qoFYSlVAbCB9DbLXW7KWh30nJYGpFdvOHVfjfrQuUj4leJYCpVUNZZ7Xbcu0fAiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbdFvTUY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbdFvTUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EWATeNQHhCFEcl8ZpvwFVEH3TVBDpbmWIAy/zadknRg=;
	b=ZbdFvTUYInmJlUIwhQ2WAJ4qkfrPz+20l58cHyPbPLokU/88XjOFy3VZx9BxKUTI595Oem
	Qw/DvbaH0vCOrnXHRFwsETKSSQq4XMm/vQFqUYRqeC+nWoQCk/3SpEVQhPBcKOB8Y8tnZf
	jso5XT6k0ylJErLCCAGLscCoi8Lw3Zg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-pYy1NR9vNhO078JBCKnlpw-1; Wed,
 13 May 2026 06:56:54 -0400
X-MC-Unique: pYy1NR9vNhO078JBCKnlpw-1
X-Mimecast-MFC-AGG-ID: pYy1NR9vNhO078JBCKnlpw_1778669813
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2A02180056E;
	Wed, 13 May 2026 10:56:52 +0000 (UTC)
Received: from ws (unknown [10.44.32.176])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D5731800465;
	Wed, 13 May 2026 10:56:51 +0000 (UTC)
Date: Wed, 13 May 2026 12:56:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Furkan Caliskan <frn1furkan10@gmail.com>
Cc: util-linux@vger.kernel.org, bensberg@telfort.nl, 
	vineethr@linux.ibm.com
Subject: Re: [PATCH] chrt: Add support for SCHED_FLAG_DL_OVERRUN
Message-ID: <vokmtg7drod6gzs5wdltod32yx5absvzf7spdne5wdu7gnv6x4@ujrijopovjn5>
References: <20260513100100.31857-1-frn1furkan10@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513100100.31857-1-frn1furkan10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, May 13, 2026 at 01:01:00PM +0300, Furkan Caliskan wrote:
> When set on a SCHED_DEADLINE task, the kernel sends SIGXCPU to the
> task if it exceeds its runtime budget within a period. Without this
> flag the task is silently throttled until the next period. Useful
> for real-time applications that need to detect when they are not
> meeting their timing requirements.

I have added this to the TODO list:
https://github.com/util-linux/util-linux/issues/4339 ;-)

It seems you (1frn10) already use GitHub. Creating a pull request
there will speed up testing, reviews, and CI.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

