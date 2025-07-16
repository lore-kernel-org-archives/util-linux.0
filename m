Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFD29E0FA
	for <util-linux@vger.kernel.org>; Wed, 16 Jul 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653792; cv=none; b=ETLfDlj3puotCcQjQ03l64qwukw0DNFg9q5yXLalTv5Yzqj3sxJL8tMDYgkGfHPBg7HmNyHjX4kiCyvjAkV/BCtNaI1IkQvrWV845g+P5OlJ6GmJLtQWQg7yLk+PhkfUOzv4L18vzqvHyolcqaz0eWEWgOLct7Y6PKa9V0VZgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653792; c=relaxed/simple;
	bh=ezO8JybbUwORehn/T7yZe/5apaO37zGDmw0fn/73UeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZWbxOMwjoxsauzvfVNTx022AB6RuGxyAtDp7/d9UzvYRc5WPbhtSVxKQ142w0iN/MRRXhm5ar1r1AQsDbKK4rDoR78kLHD5jslYwZ1HqNRYmwJaM0AUD0LqiuxnZEpLdu63StZZ6yAVewn+RsZQSLS/BdgKSDTDe5y3wb83yF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDKGqNkt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDKGqNkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752653789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXfiOH8NdVERvi5JOYT0P0q/GfhOuzZRH8ui6Ysr8RE=;
	b=SDKGqNktQ84IYm8WK6baw6ph/Qqm+yOeaEQYGP/xNE6tm0t06QGi/Xg4qjd0qE/XwZFpYu
	ov/0zIPcsg4dwgGpRrWdWbAXWzbENCBtyTUg64Oqth8X7Trjp9tuumC1V8zoHMGOHTpU0L
	jN2Mu2wyOHWFzyXO7SBO/z5QfHtFz+M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-dLCJO-3jMDahGYJsUl4lEA-1; Wed,
 16 Jul 2025 04:16:25 -0400
X-MC-Unique: dLCJO-3jMDahGYJsUl4lEA-1
X-Mimecast-MFC-AGG-ID: dLCJO-3jMDahGYJsUl4lEA_1752653784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82AC6195608E;
	Wed, 16 Jul 2025 08:16:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.225])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 445F8180045B;
	Wed, 16 Jul 2025 08:16:23 +0000 (UTC)
Date: Wed, 16 Jul 2025 10:16:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: chrt from git segfaults
Message-ID: <3pbxlgh7wj5jz5352flftxv3pmv3zvwe7ngkrwn2wa2hotha2x@n3pm4cm4fw4x>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
 <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
 <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
 <378538ce-013c-411e-93e7-ef37f2bc94ab@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378538ce-013c-411e-93e7-ef37f2bc94ab@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jul 15, 2025 at 11:19:46AM +0200, Benno Schulenberg wrote:
> 
> Op 14-07-2025 om 13:32 schreef Karel Zak:
> > I have merged Benno's V2 set of patches, so nothing else is in the
> > queue for now.
> 
> I'm not seeing those in git yet.  Did you forget to push to kernel.org?

All should be on kernel.org and github.com now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

