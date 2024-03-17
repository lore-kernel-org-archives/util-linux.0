Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141617BDC
	for <util-linux@vger.kernel.org>; Sun, 17 Mar 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710675609; cv=none; b=DQoyCWw9RJUXbtZLgmflzBlPtk+1M6UUTqn6tJB1VUeiofPAbesyU+M3hdS+LWe9SMsALkExVZifWmMRftl8X6n9YYd435K43wrweAkl6W51yuHK2oJ+RYOLsjknfcDocYFMN9zln0Qqg6EhnEVQkU9C1w8UFrcOr+s2Mv+b40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710675609; c=relaxed/simple;
	bh=1NShkcwFJXoMQp6uUEt4FJJOR5aktgdDzRSLRePUjVk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f0JhdpOmG+gvmA168qZD1OyuaWrKj4NGEZpxSmDck1njyRjWVQl1UOqYLz2M2xOMucxxVu1VsVQQwX0HdsAlM7fhvWb5jrhnf4fJ7KMmxzqnwxDxgYviMMddNji7YLTsQ2DmLzwT8W+nJiCKfUnEBCPiS4vQrftqbeeTkZClSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHlHY4eR; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draigBrady.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHlHY4eR"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513a6416058so4770305e87.1
        for <util-linux@vger.kernel.org>; Sun, 17 Mar 2024 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710675602; x=1711280402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nQCFxF+dpg/9wzkzSuUabUHGfY9fyqsLotEk8oeykAE=;
        b=MHlHY4eRgQ6SgdaYcFt+km6JUtFJmycFbFFg0FI9HnfXEVU4iEGJwOYzyNpKGTKliL
         rjOwtre6NfmlukeaATfKU0Z6WRziBe/U2u9SfYuYkBKC72Y4Lm9NzZ3QAaV314v3zIPk
         /+CNQpE9BO+n//2OcMTBaWklzc1qZ9dPHG/LNBtNBpSr1MoZ9YM+VbztuuOSYfh8LaMF
         sV//cQ8wlKqxqNTv0JGqsLdCKb3Xs9zWxsz4KV/QzH2BK4nRJ7nDFUVved2Cs0ZHFeEb
         JGwb/NeRs2UoDMrHez/VEzHLnjgqtB602On05X6ZYjLn1I0eWAAqO74Tghl/VHZkKscR
         HjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710675602; x=1711280402;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQCFxF+dpg/9wzkzSuUabUHGfY9fyqsLotEk8oeykAE=;
        b=DJnUGAResAkedExyl3cq613hYY5BPUoYUQgMUAozsm6SCOvXRaS22mIBztKg1oWIQV
         wbNmOvVtnN/l3hWLsiyZDpmoe2XWlB1wzdhCVgZlJiNy81JhKAt+9CHkZkuwd9GgJaQy
         XLzr+0wyxuXFPwMpT5bKGnSFIOLitjCQzeVgtRhpocsY3+VK8cHNVfIT3JgNClkEpENb
         yfxto3rKZ4/KVstqydAonCHEdUyhLOcRDGRJUBpzLlTK8Cg27IHkiGL4PFefyyOz4ADK
         mNiyOswlRG+/XMAzOTBIu6495JaeAa2WuStA5ajzzIc6vWMeOLGyaGTDQpy8/QjH/2et
         JZcw==
X-Forwarded-Encrypted: i=1; AJvYcCXTPTb4YbOLrazJK2MQ4wjxem4/t9kvgur4PmZBeLf4HOJhNH8Vbyx+kkELv19E+CISV6zmUfETnNWCtEghwkNbeseHOf3VniKWTg==
X-Gm-Message-State: AOJu0YyTck1WCeGnjlvPaQw3ZPfsiz5rwtVFUDMoAHkOWxY4luAnTFsX
	3SQbXBSM5GdFT1QrsjAyz1sn0Ilusiod4oH5w4AZ5xrdD2vS659zT/+/1pBX
X-Google-Smtp-Source: AGHT+IF0V9qNfWKurJ3xgdAo/I7FV0CDCmRfMuOuCqgxJa29FXwkq0YT7vGK3Y/XDFvsYKrjql2kUQ==
X-Received: by 2002:a19:740a:0:b0:513:cc23:3b6b with SMTP id v10-20020a19740a000000b00513cc233b6bmr6947252lfe.48.1710675602122;
        Sun, 17 Mar 2024 04:40:02 -0700 (PDT)
Received: from [192.168.1.39] (86-44-211-146-dynamic.agg2.lod.rsl-rtd.eircom.net. [86.44.211.146])
        by smtp.googlemail.com with ESMTPSA id f5-20020adffcc5000000b0033e7b05edf3sm7360952wrs.44.2024.03.17.04.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 04:40:01 -0700 (PDT)
Sender: =?UTF-8?Q?P=C3=A1draig_Brady?= <pixelbeat@gmail.com>
Message-ID: <9d0cd94b-0601-44e2-9218-889b1bd35336@draigBrady.com>
Date: Sun, 17 Mar 2024 11:40:00 +0000
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: 69532@debbugs.gnu.org, Petr Malat <oss@malat.biz>,
 Rob Landley <rob@landley.net>, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Karel Zak <kzak@redhat.com>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <5308840a-9de4-33d0-2520-5f3addc9718c@draigBrady.com>
In-Reply-To: <5308840a-9de4-33d0-2520-5f3addc9718c@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/03/2024 11:32, Pádraig Brady wrote:
> On 17/03/2024 06:10, Paul Eggert wrote:
>> On 2024-03-05 06:16, Pádraig Brady wrote:
>>> I think I'll remove the as yet unreleased mv --swap from coreutils,
>>> given that
>>> util-linux is as widely available as coreutils on GNU/Linux platforms.
>>
>> Although removing that "mv --swap" implementation was a win, I don't
>> think we can simply delegate this to util-linux's exch command.
>> Exchanging files via a renameat-like call is not limited to the Linux
>> kernel; it's also possible on macOS via renameatx_np with RENAME_SWAP,
>> and there have been noises about adding similar things to other
>> operating systems.
>>
>> I just now added support for macOS renameatx_np to Gnulib, so coreutils
>> does not need to worry about the macOS details; it can simply use
>> renameatu with the Linux flags. See:
>>
>> https://git.savannah.gnu.org/cgit/gnulib.git/commit/?id=af32ee824ee18255839f9812b8ed61aa5257a82b
>>
>> Even with Linux it's dicey. People may have older util-linux installed
>> and so lack the 'exch' utility; this is true for both Fedora 39 and
>> Ubuntu 23.10, the current releases. Ubuntu is also odd in that it
>> doesn't install all the util-linux utilities as part of the util-linux
>> package, so it's not clear what they will do with 'exch'.
>>
>> So I propose that we implement the idea in coreutils in a better way,
>> that interacts more nicely with -t, -T, etc. Also, I suggest using the
>> Linuxish name "--exchange" instead of the macOSish name "--swap", and
>> (for now at least) not giving the option a single-letter equivalent as I
>> expect it to be useful from scripts, not interactively.
>>
>> After looking at various ways to do it I came up with the attached
>> proposed patch. This should work on both GNU/Linux and macOS, if your OS
>> is recent enough and the file system supports atomic exchange.
> 
> The implementation looks good.
> 
> Re exch(1) on macos, I see util-linux is on homebrew,
> so it would be relatively easy to ifdef renameatx_np in util-linux also.
> 
> I think the --no-copy situation is brittle, as scripts not using it now
> would be atomic, but then if we ever supported cross fs swaps
> it may become non atomic. I'd at least doc with a line in the --exchange
> description in usage() to say something like:
>     "Use --no-copy to enforce atomic operation"
> 
> While the most flexible, it's also quite awkward to need
> `mv --exchange --no-copy --no-target-directory` for most uses.
> I.e. it's tempting to imply the --no-... options with --exchange,
> but I suppose since scripting is the primary use case for this
> flexibility trumps conciseness, so I'm ok with the verbosity I think.

Oh also in the texinfo I think it's important to mention that the swap
will "exchange all data and metadata". That's not obvious otherwise.
For example users may be wondering if only data was being exchanged
with the macos exchangedata(2) or equivalent.

cheers,
Pádraig
