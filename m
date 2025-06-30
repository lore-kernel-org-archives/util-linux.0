Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAA284B50
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284608; cv=none; b=UDoMwjs/R0KD5HqIBlCOhyFs2pb5assroqXwjV+CRYxuQQSV++XFsIixmqiInfv1xRzx7+sOYn1Hayd1QWl3WD7EaPzbSfRS6FSZExnKj5uPtJcXBOfuw+hphfeSWAmvQjOWE2XhpYUMRSSCbCLb4WKqjbSoGhCSDFaphtXfpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284608; c=relaxed/simple;
	bh=lNslOlsK8UnVlPp8uyHkYlthteWC/A5wkPRRPvXiQgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWyVRuAhetlrmbYm1tsiMAjekb88jGWnU/R8y+MinTNF7JbZa3PT9GwoopB4FBzsiplbGQaO7f7T6uHa7J1QLdXOESSJgGA02Ud2UJB2e8V454vMK3dQ482o9FTWyClZ9cQEMPOZuWAJRxCJM0FZvednioRwDMzeZXZotaxvfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoJKN7yt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoJKN7yt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751284605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NbLL/DK2Ps8Swt8T/CsUTKVDAqBC+IrkCQoWFB1vbs=;
	b=ZoJKN7ytMzNF73RQwvPgmhHqM4QmrxKcm3Lnog0z/C3YoltJHIdYGy7vMekedPEPHIaNzA
	rObm/hU176arU9m79Vu/jbYssd9xg/506CFNIZqGMVen8nryA8W1s+ePYHjytzeUhGq85J
	YcalDc2KgP0HMGI5MLD32Mm7LFw0MrE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-KftcFSTCMWC9pa9mJUFkhw-1; Mon,
 30 Jun 2025 07:56:43 -0400
X-MC-Unique: KftcFSTCMWC9pa9mJUFkhw-1
X-Mimecast-MFC-AGG-ID: KftcFSTCMWC9pa9mJUFkhw_1751284603
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1904C1801214;
	Mon, 30 Jun 2025 11:56:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C2FA19560B2;
	Mon, 30 Jun 2025 11:56:41 +0000 (UTC)
Date: Mon, 30 Jun 2025 13:56:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Jesse Rosenstock <jmr@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] gitignore: Ignore tests/diff/ and test/output/
Message-ID: <jfkk3d5zb3vbaxorisnznn5iatm7bv2ri26ulfp3iudrluu3mt@xdhrpdbgwmqo>
References: <CAMZQ0r+p--qJmjEFSTby67Rmb364A48gH9W_4RQrr+wwkJkdRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZQ0r+p--qJmjEFSTby67Rmb364A48gH9W_4RQrr+wwkJkdRw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 27, 2025 at 12:38:54PM +0200, Jesse Rosenstock wrote:
> https://github.com/util-linux/util-linux/pull/3630

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

