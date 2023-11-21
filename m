Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E2C61D92
	for <util-linux@archiver.kernel.org>; Tue, 21 Nov 2023 14:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjKUOdD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjKUOc6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 21 Nov 2023 09:32:58 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F29BA
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2023 06:32:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so5331770b3a.0
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2023 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700577166; x=1701181966; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elujBZZx0d27rJYqiCWXMNF2xv3uY/pmy4fhDpNGOfA=;
        b=M+51OuTs9bpuZY7jYe8KueSQTJH5dZsT9NEuM9pfGE1zRJsaP4WByfZU/kXOXHEf1t
         VY4xj41MW3UrT+zRZu/lAfcOECeOjuMacO4oA01+yai/EUOeslo/jteSVLLrlZmE/i6/
         LZVS9tN4tY+U2xc9QQAT0aHyZfHXSZKMTRXwA7oPi0R2eM9DOoHLwsrFMamQQQgaVRvJ
         KYWz8SbE1EYOCYZnNQ5FC6SNsWrfIh4ohNirzRUwrp0PBQBZRdoae+r5Z0RN9HhReMjx
         H910l9e75smlH9PQJ3SqMLulVRBnPR8RWY3G7ubUOEGJ1HIL8r7Ny5LtBumMJZEPqwZO
         fR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577166; x=1701181966;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elujBZZx0d27rJYqiCWXMNF2xv3uY/pmy4fhDpNGOfA=;
        b=Ul/J1VUlHWDcvdyfWkdnNKlL9878lqnQ24f9dxrDZRT/viSUiATEpnNPHY8wBmfKef
         XiykvRk6rwbxzs2Qz2K/T5KZdqsSRckScneHdTo+8krr3zJgfszSeHpsd/eFqs+aYikT
         XiV8fsdlke2A/3+PumZM13AinC6AGGpOzh39eoewtDaBYyp6urAIbJKb+mkDascnSRQR
         vQhlrFvDKV1LSyUf71CgCWMHFgYVV49nI8t9TtBQ+vyYXihFSDGuuPzCE3hVWO2oAYlj
         u1R2mUfJ+D9dw+zGQdGSagslo2tFsvCtq7MYbfwSor13t0Kf+AE+ituBSg4atgsoDGu6
         EakA==
X-Gm-Message-State: AOJu0YyyUH90/HnVVGpEO+Opy50mgtva/VZcvamuFtFOSKo5jYVOOuep
        2Wb7WxIVIEf17qHMr9K32Sj6X4rlCVk=
X-Google-Smtp-Source: AGHT+IHSjRBzHav3yb+w5mNP66b3iGZVJyIjIm66E+dC4khJuGgoCnn8locpkFjsbHogv+jZUcBDHw==
X-Received: by 2002:a05:6a00:3496:b0:6cb:bc1a:dcff with SMTP id cp22-20020a056a00349600b006cbbc1adcffmr2531653pfb.13.1700577165808;
        Tue, 21 Nov 2023 06:32:45 -0800 (PST)
Received: from [198.135.52.44] ([198.135.52.44])
        by smtp.gmail.com with ESMTPSA id w6-20020a056a0014c600b006cbb7e27091sm2156621pfu.175.2023.11.21.06.32.45
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 06:32:45 -0800 (PST)
From:   Peter Wilson <goryatwooki@gmail.com>
X-Google-Original-From: Peter Wilson <info@alrigga.com>
Message-ID: <7211793ec9b735c5587974a5f1fcf34545b1278c86d2de8f2a5ec0fc18d2563b@mx.google.com>
Reply-To: loansmanager@alriggainvestments.com
To:     util-linux@vger.kernel.org
Subject: :once again
Date:   Tue, 21 Nov 2023 06:32:44 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello util-linux,

Are you Thinking of starting a new project or expanding your business? We can fund it. Terms and Conditions Apply.

Regards,
Peter Wilson
