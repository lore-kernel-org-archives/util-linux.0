Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32C1494A0
	for <util-linux@vger.kernel.org>; Tue, 23 Jul 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775046; cv=none; b=mNVBNjqKtmuj5xbekUBJKJBzYJKWlClQVaq5dV4Ydj5TnPh1SZzkuGbXgbel4G9Y3fIPbZ6ArEQVb110qfP+cTQOCFSKzs8A6Ur+/DUwYJQNH6o3JJe+/XBD4tcN77aGxkS0fWAA4ii6BMPtvH/j8JharQryByakD8SgKPhS1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775046; c=relaxed/simple;
	bh=UVBRrCRRRm3d2JeD3hgEd3dakcfQ7BjJacGW+EAQVTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhnId3OVb4Us6/y3HK+6UmqqqQDwcv2Zc7Kr1884ztX4Z22Q1RnlD2ab0pBmS8DAevbIVO9Nxbf/LSo2Dk9LIKDar7RE0JQgzb4p4AZVaQn5WafKGy4C20dyS434INVeCSP8gsPQh/uEXrcOM+55fuYzeT9x8YrqrNHwH1UsfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C95D1F454;
	Tue, 23 Jul 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A1F13874;
	Tue, 23 Jul 2024 22:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VIszGr0zoGYZTAAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Tue, 23 Jul 2024 22:50:37 +0000
Message-ID: <8e2fba58-cc50-4309-b4ee-c1173c2ed7c5@suse.cz>
Date: Wed, 24 Jul 2024 00:50:36 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agetty: Prevent cursor escape
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20240721130142.468136-1-sbrabec@suse.cz>
 <kbdtjvbk6d7tazpqblki75tjatmqvq54hzxyybrb4uh4kjwevl@rzsfd2cofobp>
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <kbdtjvbk6d7tazpqblki75tjatmqvq54hzxyybrb4uh4kjwevl@rzsfd2cofobp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8C95D1F454
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated

Dne 23. 07. 24 v 14:56 Karel Zak napsal(a):
> On Sun, Jul 21, 2024 at 03:01:42PM GMT, Stanislav Brabec wrote:
>
>> +						write_all(1, "^[", 2);
> Not sure if we need anything more robust here. If you have access to
> the terminal, you can write whatever you want and it will be interpreted
> as a username (meaning non-terminal code will interpret it).
Anything better would be complicated. We are reading stdin byte after 
byte. So we need to do something with the yet unfinished sequence. And 
we cannot read more, as the select() guarantees just a single character. 
Ando this is just equal to ICANON | ECHOCTL terminal mode. Additionally, 
it returns behavior that was here before 8b58ffdd, but now processing 
network events better.

By the way, login is affected by the same problem. But in that case, it 
is the fault of pam. I proposed the same solution here. But in that 
case, it can be handled on the terminal level:
https://github.com/linux-pam/linux-pam/pull/816

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

