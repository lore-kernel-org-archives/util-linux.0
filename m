Return-Path: <SRS0=nETV=MT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F7C00449
	for <util-linux@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B8B2075C
	for <util-linux@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B8B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJGWF2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:05:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbeJGWF2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 7 Oct 2018 18:05:28 -0400
Received: from [192.168.101.10] ([91.1.210.52]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4alK-1g9iCS2SyU-001mC4; Sun, 07 Oct 2018 16:57:46 +0200
Received: from [192.168.101.10] ([91.1.210.52]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4alK-1g9iCS2SyU-001mC4; Sun, 07 Oct 2018 16:57:46 +0200
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
To:     L A Walsh <lkml@tlinx.org>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
 <5BB15D3A.8040507@tlinx.org> <20181002101454.qm5gzasb5naamnbg@ws.net.home>
 <5BB90C30.1080005@tlinx.org>
From:   Bernhard Voelker <mail@bernhard-voelker.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@bernhard-voelker.de; prefer-encrypt=mutual; keydata=
 xsBNBFPirzMBCACyzYldTjQ4ufFOkByY5Nn5USb5GFoL48nWBwNHjd9KUbtRRNlQiPNKd6hK
 Gvd3BGi5aoFKA4ytfRk6jbAbW3jVb3R8wYaV08mOy4KVEKxqN4bxsXlMjNChXVR+rtKDmfI+
 oPTL+cPH2X6gW4W02IRbVw0uUhNm6zEedC/gNrY/mTlf1enZ46jxZ7BTUZaG+kx38UMISIMB
 zSzLRtdkwgmHj4jS3p1fF2cwRqLclIfMjKGpbNFPEXeXKWrCLcqHw78795eAR9q0YvrDkfIn
 GdDBwfb3VM4NdulwIFzvYZMSXvSbbyPLB5YkHU5aAWQHUse4WlfT5ccDpbzUYldRAvF9ABEB
 AAHNK0Jlcm5oYXJkIFZvZWxrZXIgPG1haWxAYmVybmhhcmQtdm9lbGtlci5kZT7CwHkEEwEC
 ACMFAlPirzMCGwMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRBGUC73lpFxle5wCACC
 dbs0QaJ0vR3Sff2cKdTk41rUq3YfWngsR///IOU0C5DdkePmCnJE/lUsUy0LRTxcUDLxQR+x
 QHU8ssRT0JUO9726dI3miy36UdsgmBYaOtLvQcidGmW1R7o0PYYf04+TFtyqKgngOUBPpMgR
 6o4UsQxy/OD4bN1WDqOgIjL+D/qJpkKmgp6L6+hhaBCpiOFKRmmV7YyQ3SqVlfQNiHs5ZtkR
 nXpIjgZARV+GllKucI17bO0CGmTJZ1tstVy0+W3DQT1lbBkTTc++5LONM99D3jjn23l1ocOp
 folR53F7I4cb2RNfT23v1I59RH37lB9wMOqrKj0UjYAC2YoPGQ3BzsBNBFPirzMBCADXLWWp
 QihBldY6reca8ZKdc3T9qXEOa3akE3DWKztIBmNJhtYOjmpLYajQTkGa7UoJTnbmZE2Rn6ZE
 oNnvb0gcFNAIcY95KOI+bjOR8HEgh4cx2REXh6L6olIgyXqt/KFusE4wtVZAFxZl+30HzN6n
 D+1HvrjXxPJRX6MsIYOYyyX9/6OofwJK6QHODYGp8WL2olHDnmsXg4AT6Wlr7qKpKrQELlcF
 R4xkvdmgL/Ghw/tK0yJTxMIcewCCZWLPOXRmFRbvAadZWPAgVsJ63siNyUlVnVMSzDgTJl+s
 l/DMabXpqrJQx3/1Yy6mTaDs3XZT/wmBKaTLXx/LByaPxQQ7ABEBAAHCwF8EGAECAAkFAlPi
 rzMCGwwACgkQRlAu95aRcZWVPwgAqZT6iTXkoP37wYb41323RzhBcJ8JSk4cyBDBUXX0lMrM
 3qhiClKG7phpxVdu817Gwc6Hsecg7FfjQAV8MHQ0ZFeEFdk3b2rKBqfsStc+h49/xF3Fb+if
 CzR9qeQF82fMSxkg18++7hMcHCMO/hPZ/Q0xRi+lrSr2QKDJQuLzSyVU14TxrCkevZjEhtma
 VNvcJlJzCbiBXee9Fpc5jITUXPFG8E8dxqo1n+duOyIMgozrAnzP7X5V/Ob/Ozf/aGGX9+Jd
 inyfCX18nWcHALKMU/36Eua/ylalf/2c2YkBp9KCLVmGgPkUgW52EeRPgroIsiwu+rwCSV6Z
 UyCJ+OymCg==
Message-ID: <a8f5fac6-b7a3-ee92-3f5b-b6459cdc3b5f@bernhard-voelker.de>
Date:   Sun, 7 Oct 2018 16:57:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5BB90C30.1080005@tlinx.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Z3ebtLaElejZR1rH4jhUCyMxKlpmYN7f8uCPC8NfNu2Txka4SFd
 sKZRxJnxxSrI3O4CJNjQ6fAdG6RELWQ+crb1LOUh0ziR85k+QmVL+Vwmk8bhflp7B/4TX4Q
 8fW3exQFXX+dBruHE6KOsOqIri4mauBaa9+sRaM70bdErYtTDlX4DF1euCIV3SWwZ0H6KIm
 /FjQE97j5+qWMoTNpzZhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J0E8ipwrGh0=:Y7lkfoIknZgb4aotpxQnsj
 0zTXI/7REBtOmqc3oLwf0PwscE8kfBRKr7K+qUAjyLQrha11VUaRaou1lLVyh9A3uoGU+Ktzm
 FRWsO6uTk8Ga3Rq1/ziHjr52o04adn3ZVdLqoJ271ZO07weNgxCn5P1qcqJ4F++bXmOhvw6kY
 dm2DeSSREZeUYXVPnKIo38brkROnTBD9H0OO4YeT6Z1KI0OYo00Vp6/o4HJ44TlWeeHmEw/Kt
 TjU3kpRDpcwfxKEC4wpo97RdRFh20zxUtvqFcWg6Kq4gof2WMfmDHadH6lcUPRxTr/0jvIsFK
 bEMpHFxzdmqbAPxen26hZ/Ajj+w0OhPjACxiTfGWH/mUHA+ASERbPrarVDdG9XYyQkX3YFOw6
 dmW5J671w6cKknraIEBdyfcRcrLxO/7hA3+LQ4yUrFQYmt8m5gUC7zg5+B1tD5NH3F0usD2q6
 ThzXcFkVD+ICfSdnX4JPTQ1CuAOpSunjDRb6IYr/o++qZ9oLuiAvyIM0rNhysReYbPj6hQCl5
 hLtCPIzUVYJ1fCLP3arNgubE2YpzeujWNh1W26Y2/OBhu3B8OHnDh2enI0NOknxyUUZuuP/C5
 wSOJrfRu9fx5k1kjmzbrT9VSUKvYTHyyEO1MCw7NiXDrGk1zG19Kk5TfwXitYb1Nc6Y4NgfEW
 iocXG9M98uzBuHXJcihzlj66tVZE2iYWPBeO0gZm+NgTAD7myoxgJdHCuGL1PXmYYSqd9QouT
 gS11exFt2lireysp
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/6/18 9:25 PM, L A Walsh wrote:
> On 10/2/2018 3:14 AM, Karel Zak wrote:
>> On Sun, Sep 30, 2018 at 04:33:14PM -0700, L A Walsh wrote:
>>   
>>> On 9/25/2018 3:47 AM, Karel Zak wrote:
>>>     
>>>> The commands mount and umount
>>>>       
>>> ---
>>>   I note that umount has a static option umount.static, but I don't see
>>> the same for mount (i.e. mount.static).
>>>     
>>
>>  $ ./configure --enable-static-programs=mount,umount
>>  $ make mount.static umount.static
>>
>> works for me:
>>   
> so I see...  Except I got:
>   CC       sys-utils/mount_static-mount.o
>   CCLD     mount.static
> libtool: warning: complete static linking is impossible in this 
> configuration
> /usr/bin/ld: total time in link: 0.038189
>   CC       sys-utils/umount_static-umount.o
>   CCLD     umount.static
> libtool: warning: complete static linking is impossible in this 
> configuration
> /usr/bin/ld: total time in link: 0.039017
> 
> with ldd:
> Ishtar:tools/util-linux/util-linux-2.33-rc1> ldd mount.static
>   linux-vdso.so.1 (0x00007ffc38d78000)
>   librt.so.1 => /lib64/librt.so.1 (0x0000003001c00000)
>   libc.so.6 => /lib64/libc.so.6 (0x0000003000800000)
>   libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003000c00000)
>   /lib64/ld-linux-x86-64.so.2 (0x00007f81b9262000)
> 
> It seems something about my config (or Suse's config) is creating a problem
> for static linking.  I should probably ask on the Suse list
> to see if anyone as run into this or solved it, though if you
> have any ideas or known probs, great!

$ zypper install glibc-devel-static
