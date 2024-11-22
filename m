Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4E1304BA
	for <util-linux@vger.kernel.org>; Fri, 22 Nov 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265667; cv=pass; b=mTB0eqqJ4h7uAlMKlih5MhV1UsltltitexYPmfRXjp5L8TVRNeQGZsZjDaRJV91DNzswhN5PM2iNbXtu1wemv8RJ4AlKft1/0/N0vKyVUg/UlxVBv3aGt65sMeRItBOEVmUk0SEowODkGUr9DYnY8xdboTUIwIotPZr0pCIeUjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265667; c=relaxed/simple;
	bh=iwMb1uxt4HhWIgCf0yOoEmUX0KtraQAL7UBwonp9OmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWbiFsfYRAWckRLbmoWwWuX55Ic4hH8eE/4ruueYIkKIxEHNbeWYC4Ewf5XNckAOPXUtvtUhUwIvdO7BtyOzIzrX5bSsM4ehmDn149cF9dRlGKNDLDQ/tBWn8JFzB8RLiwH6F30Av5XVNn5hB/eofWtd1ALbtB9KbSCLyMgqaR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=P/tmChtd; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="P/tmChtd"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 48E818A36AC
	for <util-linux@vger.kernel.org>; Fri, 22 Nov 2024 08:54:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.122.114.75])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DD1C18A2564
	for <util-linux@vger.kernel.org>; Fri, 22 Nov 2024 08:54:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732265657; a=rsa-sha256;
	cv=none;
	b=wOGzutPdF2d2y+W1I1ov7uOnX0EolAtHJp2xqlgL7YBsYy67AJhnh7UODnf8uh6AoGl8i8
	yxfNuk9TkUELEkt32rbg8s/QSo0e5qMN1glM1e7aYMZbAxw+B0jwpmzqA1FfdQyPSL2uT4
	gFpgjDPa7YqZYqfz/CpPt82g8etFIVRLOpwrn/62iPFa4XaK60HGmfL8HFDscToijJOjA2
	nszvW18ZxTpA9gqpHMd29RDBJ01ReEZzsP3zbpq7FQ2l/NryXuJzg2ZxHnMEmo8Dy5Tftt
	0S76BhjqiyiU5tAz6Mh+v9FxhXwNG5BGpIvhqsW1B47gdbc7XUn5jw4jHfUx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732265657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Hzjz5diVJm30+I8uk9bzm87aXhkjgYkqOsJzlD+LEs8=;
	b=r1vvCKN77h9DqiJpK8QCotn/egaNNITfn5UIwXwzpGcC5D4s+I8D/8SMp8BFNqeNYZvzo2
	vrs9Vm6VOCTdes1r9Eh5KxND6eh6/F1earHRdI4SvfB1shuVYOPcFn1ogNv17JQfy6BxuV
	3+eZj9mWfk9xPNKSrU1rK9IzSVxtMfecCwXFhDxlc2pUCd/uKtroGuX4h/gI0uvqEtYyRA
	KQ7opOsgaAqQXIhVgnTZA1wNTTzuToimTG+S/JhZYriRZt8Y8tBhGZsxETC92gv3OL05Qh
	/wPbeir1EfNcagwc8vEYv+l84P+NBwNlTavH2qKD9LX87R83+Fm7J4oyn3ohOA==
ARC-Authentication-Results: i=1;
	rspamd-868968d99d-pjmdv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Absorbed: 0589315335c3b03a_1732265658155_2007522082
X-MC-Loop-Signature: 1732265658155:165572939
X-MC-Ingress-Time: 1732265658154
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.114.75 (trex/7.0.2);
	Fri, 22 Nov 2024 08:54:18 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Xvpn54TL0zJ9
	for <util-linux@vger.kernel.org>; Fri, 22 Nov 2024 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732265657;
	bh=Hzjz5diVJm30+I8uk9bzm87aXhkjgYkqOsJzlD+LEs8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=P/tmChtdZ56PwFBLJ29HMetgXo3FM1x6mbgNdfu5dWquLMy+07JkNZHyXTtFR14ud
	 8Xa9Pu8pAtJ2ZCDOifqT1ezDuzHlSguHJ0pwyhki/vCZIpLcW56iIU3eXhNuEzItqt
	 vh/HXWacZ8FgeF1TXQTq82+6jNugB8EIxviNLv/GPQwElXCW/aU0Tp88hB7FP55/lY
	 5TPttx6HHBlgojufplaCSHyaeHIT4HuoMZe+75dEvsmdaOqEieBgGKH1wNkWF7GZnZ
	 Bs3Yb/Qpv85Bt40VWnyG5IGTSzHFNKY2QVfTz/LabmmSsb/LileRnE/2x/D06KyoC+
	 s6XALPb+LDnqA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e006b
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 22 Nov 2024 00:54:16 -0800
Date: Fri, 22 Nov 2024 00:54:16 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Karel Zak <kzak@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
	"systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>,
	David Reaver <me@davidreaver.com>
Subject: Re: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Message-ID: <20241122085416.GA7186@templeofstupid.com>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <7bc43689ca4249f18c60fa4b063822ea@ukr.de>
 <20241119174957.GA3484088@mit.edu>
 <cu2l7alrme6y7mm3kjmdnszyc7ka4a6zh5lw3ps3vj7igzjpkv@t7pgmn4aztkj>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cu2l7alrme6y7mm3kjmdnszyc7ka4a6zh5lw3ps3vj7igzjpkv@t7pgmn4aztkj>

On Thu, Nov 21, 2024 at 11:44:14AM +0100, Karel Zak wrote:
> On Tue, Nov 19, 2024 at 09:49:57AM GMT, Theodore Ts'o wrote:
> > The O_DIRECT read isn't a magic bullet. 
> 
> Hmm... the nice thing about this patch is that it only uses O_DIRECT
> when necessary (if the ordinary method fails). This means that it does
> not add complexity or overhead to regular FS probing.

Let me know if there are additional changes you'd like me to make to
this patch.  I hope that it's not too unappealing.  It's resolved the
problem in our environment where we went from seeing this about 20ish
times a day to none.

-K
