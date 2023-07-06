Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657CEB64DA
	for <util-linux@archiver.kernel.org>; Thu,  6 Jul 2023 00:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGFAXp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Jul 2023 20:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGFAXo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Jul 2023 20:23:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F5419A9
        for <util-linux@vger.kernel.org>; Wed,  5 Jul 2023 17:23:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so1344255e9.2
        for <util-linux@vger.kernel.org>; Wed, 05 Jul 2023 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688603021; x=1691195021;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsAHZhp8r1n5aqUZR8dz0+3Z6pg3AOzecPjny7+jOrQ=;
        b=S83Io7KFt5nE2skhJc/xvqmj/TrybG1PhY9bmg6e1ubSweAf1L2gg6QxfKUKgZn+Sw
         M5F/xE570HNK2pfUajBSMAsdaDgt0tDoUxrDG6LYp2sMNZLMz8icQ5ZSAFmG3fzropP/
         WSby0k7GVyfEoWSB2zYywysL6jZPmhhcRZf3xkqkJwE08RVt/m46xLF4r4oevLktDAD9
         oPDIsW03FuSqw8i1MIT10fSjXwSMD/nVxXxODSe3DPhNuK7bmFEerTBuR0RGJBgp/li9
         +pyQrf+DdnTlePpP6FHvXd409tIx2RDWQRxYfy7yMFmPB3WAOWoWhKZA3znsi9kZNwvE
         Sr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603021; x=1691195021;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsAHZhp8r1n5aqUZR8dz0+3Z6pg3AOzecPjny7+jOrQ=;
        b=EBJnvIICiqpCQUQZgdrtJxraNoJtd8qJszaUStY2IYhyuyrqEp5lh1kgO+yYLTz++9
         SCqsYp7Pnsc0eg1xNdWiH9L9qq+HExubDFhQYD6e7L+f7L6+VhEwxMKz2TCVlMj2bzEz
         h8D+bphn9ZdCjBPwTaQqufy4jMHIrVjUoaA8s0/+TBS9JMAVEvzjuxo6goze9den1sjj
         QWhh2RMnhd9EYhcVCq/FgH39vH0aOwiWJJ5haJ/2/03j93D7bm12wtRWGo1KHy2WUtgX
         7lsFmH3otmI7dHR980dp7ajfzJeE7x8A2EBIyI5cNxOKNMYi9g/6bUoiqyoE+gaArlVe
         EHeQ==
X-Gm-Message-State: ABy/qLYDo4qmEUSZ99fKhuJO4FFsyhx5stzyOaCLbRki+UfHH1aTD0po
        T4r9FQgYc+tOi/zqbNSAp1IgqhLjk3jY4HwXEtqcPu98ZXw=
X-Google-Smtp-Source: APBJJlGb4/bZVfp1g86/JQBOIvITXTos53Y7s1VV2GmGEb1i5qYaZx7SUYffL+/FZXymSujaF7m0wgubJtIu7wJUcwM=
X-Received: by 2002:a7b:cbd2:0:b0:3fb:e2e0:1d52 with SMTP id
 n18-20020a7bcbd2000000b003fbe2e01d52mr249389wmi.13.1688603021021; Wed, 05 Jul
 2023 17:23:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6848:0:b0:314:3abb:5c6c with HTTP; Wed, 5 Jul 2023
 17:23:40 -0700 (PDT)
Reply-To: lyman@alum.mit.edu
From:   Lyman Opie <jf02ir@gmail.com>
Date:   Wed, 5 Jul 2023 20:23:40 -0400
Message-ID: <CAGLH8RSpmqZJOvcO+1so1zz4q9cs5GyEtGL9oZ8as0tAemCo8g@mail.gmail.com>
Subject: May I help you to fix the source code for util-linux?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Dear friends who have worked on the util-linux source code,

Thank you for the util-linux package.

I'm an M.I.T. graduate, who has been compiling linux source code for
almost as long it has existed.  A problem has crept into the
util-linux source code:

When I run its "configure" script, it eventually fails, reporting
  error: C++ preprocessor "/lib/cpp" fails sanity check

The lack of sanity is not in cpp, but in the configure script, which
calls cpp with a command line tens of thousands of characters long,
which consists almost entirely of thousands of repetitions of the
command-line arguments "-D _GNU_SOURCE".

I am looking into a way to fix this, but perhaps someone who is
already familiar with the source code can tell me immediately how this
might be fixed?

If someone has a chance to email me, I'd be pleased to hear from you.
I thank you kindly for reading.

Very truly yours,

Lyman Opie
lyman@alum.mit.edu
