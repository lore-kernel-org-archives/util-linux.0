Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F84A1A
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492783; cv=none; b=aMweVtVP4ZmYr+d0FjBgZNBq02lMpKUTtytrZsSiPlXnM72moYwB9NH8h470+o0CPl2oNmQTCSIqCYdc0dlphBR9Z4+k3RdRqMtdjymTBifhpyikLFbDzhboRH+yUZJGiPhvgIatAqRaTocPZuENIdlxVWGgXb+Lfh1zYRYZHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492783; c=relaxed/simple;
	bh=k55wWusH+46kBdG4wOLzrkXx0gcQYZmv90kqi8Rakvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAZgIv2mcQvDERh6Bq4rI0Luk7T2zfZpAQ5BSDCjdVK5bu93q/T+ps/E/ejxJYRETMG9xDuAS30LFCT6p+12xuMmZulEkPq0ZmDylTQ4gzT2xawS1BZPnNNfGze+sm0S9gFOZkWKAsvY2NkAH4VPbKcC86z1iQaTSR+03LXYeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRnbzwKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRnbzwKy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752492780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0Jpnb42UP8GZsegOcZ0WOBVYUpqzdinMMdVfx1JJVo=;
	b=JRnbzwKyTBYauD+QuFcNCwS12jTBHwIrDnT1pESFKrKh4/EDqK0t+kDCvh6Ag49Gy6trPY
	WyPdtcnub9aiwxV+XbiK6nyZu8xjdjPBGdhqPgW+DHlUpYT7zmy388YxO6RMAWRyqj7UKT
	nVhgi5VLOGEHsKeFYQwLPvfeCZ/7YwA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-nnKQqBYDMKWNQ9YKP2fw5Q-1; Mon,
 14 Jul 2025 07:32:58 -0400
X-MC-Unique: nnKQqBYDMKWNQ9YKP2fw5Q-1
X-Mimecast-MFC-AGG-ID: nnKQqBYDMKWNQ9YKP2fw5Q_1752492777
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C0B7180029E;
	Mon, 14 Jul 2025 11:32:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.225])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6008419560A3;
	Mon, 14 Jul 2025 11:32:54 +0000 (UTC)
Date: Mon, 14 Jul 2025 13:32:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: chrt from git segfaults
Message-ID: <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
 <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jul 10, 2025 at 10:11:58AM +0200, Benno Schulenberg wrote:
> 
> Op 09-07-2025 om 20:45 schreef Madadi Vineeth Reddy:
> > Could you spin off a patch to make sure the priority argument is
> > optional for policies that don’t need it, even when --pid is not used?
> 
> No.  You broke it, you fix it.

Please, please, don't forget to finalize it to avoid releasing it
incomplete ;-)

I have merged Benno's V2 set of patches, so nothing else is in the
queue for now.

Thanks guys!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

