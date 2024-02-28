Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC2148FFC
	for <util-linux@vger.kernel.org>; Wed, 28 Feb 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129179; cv=none; b=BiL5tBco2PKnnVfeLxTjvT7sgrcMF1dytJGixknTPnWJ2yE3I8NIp7vn9KV0iSSscBV+3+Nw9Q9FiM2O2R27VKJSoD7kkWxjLHXtqJdTL9jKa3SCCP6gFcpUQKplQ8VKWacGedbc9lm6HmI5g/rOgSeDjdQaXQGSH5goa8ExSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129179; c=relaxed/simple;
	bh=5uMBnG/+GO4lxoKCVltmf/gDAhCxewL/m1yMD00xIOU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Gg2KbmZWux1jFHKbpOAxnV644ie2+UT/3ISN7iiCsUCPbXJTYwqEMNoxQ4vht25KSzouRmoWx03OWx8FNmxFu5uweOz/5vtvygKUqiKtVZNaf7Hyll7W4eyJwZ2MAovnCg0WcSzouya587+IIAUcEvNfdnaE1IqbQCoGHpMDLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UMj+6UAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u67YjtTu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UMj+6UAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u67YjtTu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UMj+6UAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u67YjtTu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UMj+6UAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u67YjtTu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D95221C2B
	for <util-linux@vger.kernel.org>; Wed, 28 Feb 2024 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709129175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9pnkiD4tYErhB4QNrR2PupgegDWS0jHtxZ14gmKIc8=;
	b=UMj+6UACgMlttqWqNYZf8J5ls3ECus48KP3Fq+9alTtKMEJhdY54bL7N0pC9CC1gHQgLlI
	QaGBe9Hf//kNeKsy80im3DQlcSEYO61INUEpGiiTf9h4ESTxBT9QZN5zeNcECAnh0H5NWb
	rECiTS/0HxytyS2bcyOTeUvOYFI0apo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709129175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9pnkiD4tYErhB4QNrR2PupgegDWS0jHtxZ14gmKIc8=;
	b=u67YjtTu+6VQ1bzb1GEKZYwwvMxp8nD+8YWY8HNlQmsO34wE+RPS1aNvKpxRr6m7YVL6D0
	Po+lDg/gS78lxmDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709129175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9pnkiD4tYErhB4QNrR2PupgegDWS0jHtxZ14gmKIc8=;
	b=UMj+6UACgMlttqWqNYZf8J5ls3ECus48KP3Fq+9alTtKMEJhdY54bL7N0pC9CC1gHQgLlI
	QaGBe9Hf//kNeKsy80im3DQlcSEYO61INUEpGiiTf9h4ESTxBT9QZN5zeNcECAnh0H5NWb
	rECiTS/0HxytyS2bcyOTeUvOYFI0apo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709129175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9pnkiD4tYErhB4QNrR2PupgegDWS0jHtxZ14gmKIc8=;
	b=u67YjtTu+6VQ1bzb1GEKZYwwvMxp8nD+8YWY8HNlQmsO34wE+RPS1aNvKpxRr6m7YVL6D0
	Po+lDg/gS78lxmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 350AC13A5D
	for <util-linux@vger.kernel.org>; Wed, 28 Feb 2024 14:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8aOjC9c932UfbwAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Wed, 28 Feb 2024 14:06:15 +0000
Message-ID: <2b12341f-5935-463c-8301-a4a4f139541c@suse.cz>
Date: Wed, 28 Feb 2024 15:06:14 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] setterm: Document behavior of redirection
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[18.52%];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:url,suse.com:email];
	 TO_DN_EQ_ADDR_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

Debugging an error of setterm, I realized that setterm --powerdown operates
on stdout but setterm --powersave operates on stdin. Such unexpected
behavior should be documented.

I prefer a less accurate generic "always redirect both stdin and stdout"
over recommending of the correct I/O stream for each option separately.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  term-utils/setterm.1.adoc | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/term-utils/setterm.1.adoc b/term-utils/setterm.1.adoc
index 880fe10d6..365c4bb00 100644
--- a/term-utils/setterm.1.adoc
+++ b/term-utils/setterm.1.adoc
@@ -156,6 +156,10 @@ Turns underline mode on or off.

  include::man-common/help-version.adoc[]

+== WARNING
+
+Use of *setterm* in combination with stdout redirection can have 
unexpected results, as some options operate on stdin. To prevent 
problems, always redirect both stdin and stdout to the same device.
+
  == COMPATIBILITY

  Since version 2.25 *setterm* has support for long options with two 
hyphens, for example *--help*, beside the historical long options with a 
single hyphen, for example *-help*. In scripts it is better to use the 
backward-compatible single hyphen rather than the double hyphen. 
Currently there are no plans nor good reasons to discontinue 
single-hyphen compatibility.
-- 
2.43.0

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

