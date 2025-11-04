option casemap:none

extern __imp_AdjustWindowRect: qword
extern __imp_CloseClipboard: qword
extern __imp_CreateFontIndirectW: qword
extern __imp_CreateWindowExW: qword
extern __imp_DefWindowProcW: qword
extern __imp_DeleteObject: qword
extern __imp_DestroyWindow: qword
extern __imp_DispatchMessageW: qword
extern __imp_EmptyClipboard: qword
extern __imp_ExitProcess: qword
extern __imp_GetClipboardData: qword
extern __imp_GetDC: qword
extern __imp_GetDeviceCaps: qword
extern __imp_GetMessageW: qword
extern __imp_GlobalAlloc: qword
extern __imp_GlobalFree: qword
extern __imp_GlobalLock: qword
extern __imp_GlobalUnlock: qword
extern __imp_IsClipboardFormatAvailable: qword
extern __imp_LoadCursorW: qword
extern __imp_LoadIconW: qword
extern __imp_MessageBoxW: qword
extern __imp_OpenClipboard: qword
extern __imp_PostQuitMessage: qword
extern __imp_RegisterClassExW: qword
extern __imp_RegisterClipboardFormatW: qword
extern __imp_ReleaseDC: qword
extern __imp_SendMessageW: qword
extern __imp_SetClipboardData: qword
extern __imp_SetProcessDPIAware: qword
extern __imp_ShowWindow: qword
extern __imp_TranslateMessage: qword
extern __imp_UpdateWindow: qword
extern __ImageBase: qword

.data?
hwndsubctrl dq  6 dup(?)
clipboardid dd  3 dup(?)

.const
clipname0   dw  'A','u','t','o','C','A','D',' ','2','0','0','8',' ','I','n','t','e','r','n','a','l',' ','M','T','e','x','t',' ','C','l','i','p','b','o','a','r','d',' ','D','a','t','a',0
clipname1   dw  'A','u','t','o','C','A','D',' ','U','n','i','c','o','d','e',' ','D','i','m','e','n','s','i','o','n',' ','C','l','i','p','b','o','a','r','d',' ','D','a','t','a',0
clipname2   dw  'A','u','t','o','C','A','D',' ','U','n','i','c','o','d','e',' ','D','i','m','e','n','s','i','o','n',' ','A','l','t',' ','C','l','i','p','b','o','a','r','d',' ','D','a','t','a',0
programname dw  'A','u','t','o','C','A','D',' ','M','T','e','x','t',' ','C','l','i','p','b','o','a','r','d',' ','V','i','e','w','e','r',0
msgtitle0   dw  09519h,08BEFh,0;错误
msgregclip  dw  06CE8h,0518Ch,0526Ah,05207h,0677Fh,05931h,08D25h,0FF01h,0;注册剪切板失败！
msgregclass dw  0521Bh,05EFAh,04E3Bh,07A97h,053E3h,05931h,08D25h,0FF01h,0;创建主窗口失败！
ctrlstatic  dw  'S','t','a','t','i','c',0
ctrledit    dw  'E','d','i','t',0
ctrlbutton  dw  'B','u','t','t','o','n',0
ctrlstatic0 dw  'A','u','t','o','C','A','D',' ','2','0','0','8',' ','I','n','t','e','r','n','a','l',' ','M','T','e','x','t',' ','C','l','i','p','b','o','a','r','d',' ','D','a','t','a',':',0
ctrlstatic1 dw  'A','u','t','o','C','A','D',' ','U','n','i','c','o','d','e',' ','D','i','m','e','n','s','i','o','n',' ','C','l','i','p','b','o','a','r','d',' ','D','a','t','a',':',0
ctrlstatic2 dw  'A','u','t','o','C','A','D',' ','U','n','i','c','o','d','e',' ','D','i','m','e','n','s','i','o','n',' ','A','l','t',' ','C','l','i','p','b','o','a','r','d',' ','D','a','t','a',':',0
ctrlbutton0 dw  08BFBh,053D6h,0;读取
ctrlbutton1 dw  05199h,05165h,0;写入
ctrlbutton2 dw  09000h,051FAh,0;退出
msgtitle1   dw  08B66h,0544Ah,0;警告
msgopenclip dw  06253h,05F00h,0526Ah,05207h,0677Fh,05931h,08D25h,0FF01h,0;打开剪切板失败！
msgeptyclip dw  06E05h,07A7Ah,0526Ah,05207h,0677Fh,05931h,08D25h,0FF01h,0;清空剪切板失败！
msgreadclip dw  08BFBh,053D6h,0526Ah,05207h,0677Fh,05931h,08D25h,0FF1Ah;读取剪切板失败：
msgwritclip dw  05199h,05165h,0526Ah,05207h,0677Fh,05931h,08D25h,0FF1Ah;写入剪切板失败：

.code
winmain proc
    push    rbx
    sub     rsp,80h                                     ;分配局部变量和函数参数的栈空间，包括影子空间
    call    qword ptr[__imp_SetProcessDPIAware]         ;设置系统DPI感知
    lea     rcx,[clipname0]
    call    qword ptr[__imp_RegisterClipboardFormatW]
    test    eax,eax
    je      $1
    mov     dword ptr[clipboardid+00h],eax
    lea     rcx,[clipname1]
    call    qword ptr[__imp_RegisterClipboardFormatW]
    test    eax,eax
    je      $1
    mov     dword ptr[clipboardid+04h],eax
    lea     rcx,[clipname2]
    call    qword ptr[__imp_RegisterClipboardFormatW]
    test    eax,eax
    je      $1
    mov     dword ptr[clipboardid+08h],eax
    mov     qword ptr[rsp+20h],50h                      ;cbSize & style
    lea     rax,[winproc]
    mov     qword ptr[rsp+28h],rax                      ;lpfnWndProc
    mov     edx,00000001h                               ;图标资源ID
    lea     rcx,[__ImageBase]
    mov     qword ptr[rsp+38h],rcx                      ;hInstance
    call    qword ptr[__imp_LoadIconW]
    mov     qword ptr[rsp+40h],rax                      ;hIcon
    mov     edx,00007F00h                               ;IDC_ARROW
    xor     ecx,ecx
    mov     qword ptr[rsp+30h],rcx                      ;cbClsExtra & cbWndExtra
    mov     qword ptr[rsp+58h],rcx                      ;lpszMenuName
    mov     qword ptr[rsp+68h],rcx                      ;hIconSm
    call    qword ptr[__imp_LoadCursorW]
    mov     qword ptr[rsp+48h],rax                      ;hCursor
    mov     qword ptr[rsp+50h],10h                      ;hbrBackground
    lea     rax,[programname]
    mov     qword ptr[rsp+60h],rax                      ;lpszClassName
    lea     rcx,[rsp+20h]
    call    qword ptr[__imp_RegisterClassExW]           ;注册窗口类
    test    ax,ax
    je      $2
    mov     word ptr[rsp+7Ch],ax                        ;ATOM窗口类类原子
    xor     ecx,ecx
    call    qword ptr[__imp_GetDC]
    mov     edx,5Ah                                     ;下一函数参数：LOGPIXELSY
    mov     rcx,rax                                     ;下一函数参数：hdc
    mov     rbx,rax                                     ;上一函数返回：hdc
    call    qword ptr[__imp_GetDeviceCaps]              ;获取当前的系统DPI
    mov     rdx,rbx                                     ;下一函数参数：hdc
    xor     ecx,ecx                                     ;下一函数参数：NULL
    mov     ebx,eax                                     ;上一函数返回：dpi
    call    qword ptr[__imp_ReleaseDC]
    test    ebx,0FFFF0000h                              ;这里限制一下，DPI只支持到65535，省得要考虑溢出的事
    jne     $2
    lea     eax,[ebx+04h]
    shr     eax,03h
    neg     eax                                         ;字体高度
    mov     rcx,8600000000000190h
    mov     rdx,4F535B8B02000000h
    mov     qword ptr[rsp+20h],rax                      ;lfHegigt & lfWidth
    mov     qword ptr[rsp+28h],00h                      ;lfEscapement & lfOrientation
    mov     qword ptr[rsp+30h],rcx                      ;lfWeight & lfItalic & lfUnderline & lfStrikeOut & lfCharSet
    mov     qword ptr[rsp+38h],rdx                      ;lfOutPrecision & lfClipPrecision & lfQuality & lfPitchAndFamily
    mov     word ptr[rsp+40h],dx
    lea     rcx,[rsp+20h]
    call    qword ptr[__imp_CreateFontIndirectW]        ;创建“宋体”字体
    lea     ecx,[ebx+ebx*2]                             ;结合DPI计算主窗口客户区高度，为242个单位
    lea     ecx,[ebx+ecx*8+10h]
    shr     ecx,05h
    lea     ecx,[ecx+ebx*2]
    add     ecx,ebx
    lea     edx,[ebx+ebx*4]                             ;结合DPI计算主窗口客户区宽度，为267个单位
    lea     edx,[ebx+edx*2+20h]
    shr     edx,06h
    lea     edx,[edx+ebx*4]
    shl     rcx,20h                                     ;高度存储在高32位
    or      rcx,rdx                                     ;宽度存储在低32位
    mov     qword ptr[rsp+60h],rax                      ;保存字体句柄给WM_CREATE消息使用
    mov     qword ptr[rsp+68h],rcx                      ;保存宽高信息给WM_CREATE消息使用
    mov     dword ptr[rsp+70h],ebx                      ;保存DPI信息给WM_CREATE消息使用
    xor     r8d,r8d
    mov     edx,00CA0000h                               ;WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX
    mov     qword ptr[rsp+20h],r8
    mov     qword ptr[rsp+28h],rcx
    lea     rcx,[rsp+20h]
    call    qword ptr[__imp_AdjustWindowRect]           ;通过所需的主窗口客户区宽高计算其整体需要的宽高
    mov     eax,dword ptr[rsp+28h]
    sub     eax,dword ptr[rsp+20h]
    mov     ebx,dword ptr[rsp+2Ch]
    sub     ebx,dword ptr[rsp+24h]
    lea     rcx,[__ImageBase]
    lea     rdx,[rsp+60h]
    mov     qword ptr[rsp+58h],rdx
    mov     qword ptr[rsp+50h],rcx
    mov     qword ptr[rsp+48h],00h
    mov     qword ptr[rsp+40h],00h
    mov     dword ptr[rsp+38h],ebx
    mov     dword ptr[rsp+30h],eax
    mov     dword ptr[rsp+28h],80000000h
    mov     dword ptr[rsp+20h],80000000h
    mov     r9d,00CA0000h                               ;WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX
    lea     r8,[programname]
    movzx   edx,word ptr[rsp+7Ch]                       ;ATOM窗口类类原子
    xor     ecx,ecx
    call    qword ptr[__imp_CreateWindowExW]
    mov     rbx,rax
    mov     edx,05h
    mov     rcx,rbx
    call    qword ptr[__imp_ShowWindow]
    mov     rcx,rbx
    call    qword ptr[__imp_UpdateWindow]
$0: xor     r9d,r9d
    xor     r8d,r8d
    xor     edx,edx
    lea     rcx,[rsp+20h]
    call    qword ptr[__imp_GetMessageW]
    test    eax,eax
    je      $4
    lea     rcx,[rsp+20h]
    call    qword ptr[__imp_TranslateMessage]
    lea     rcx,[rsp+20h]
    call    qword ptr[__imp_DispatchMessageW]
    jmp     $0
$1: lea     rdx,[msgregclip]
    jmp     $3
$2: lea     rdx,[msgregclass]
$3: mov     r9d,00000010h                               ;MB_ICONERROR
    lea     r8,[msgtitle0]
    xor     ecx,ecx
    call    qword ptr[__imp_MessageBoxW]
    jmp     $5
$4: mov     rcx,qword ptr[rsp+60h]
    call    qword ptr[__imp_DeleteObject]
$5: add     rsp,80h                                     ;释放局部变量和函数参数的栈空间，包括影子空间
    pop     rbx
    xor     ecx,ecx
    jmp     qword ptr[__imp_ExitProcess]
winmain endp
winproc proc
    cmp     edx,01h                                     ;WM_CREATE
    jne     $0
    mov     qword ptr[rsp+20h],rbx                      ;保存非易失性寄存器到影子空间
    mov     qword ptr[rsp+18h],rbp
    mov     qword ptr[rsp+10h],rsi
    mov     qword ptr[rsp+08h],rdi
    sub     rsp,78h                                     ;开辟非易失性寄存器入栈预留空间、成员变量空间、影子空间
    mov     qword ptr[rsp+70h],r12                      ;保存非易失性寄存器到预留空间
    mov     qword ptr[rsp+68h],r13
    mov     qword ptr[rsp+60h],r14
    mov     r12,rcx                                     ;hwnd
    lea     r13,[__ImageBase]                           ;hInstance
    mov     r14,qword ptr[r9]                           ;lpCreateParams
    mov     ebx,dword ptr[r14+10h]                      ;dpi
    lea     ebp,[ebx+ebx*2+10h]                         ;结合DPI计算控件距离客户区边界的距离，6个单位
    shr     ebp,05h
    mov     esi,dword ptr[r14+08h]                      ;结合DPI计算Static和Edit控件的宽度，255个单位
    sub     esi,ebp
    sub     esi,ebp
    lea     edi,[ebx+04h]                               ;结合DPI计算Static控件的高度，8个单位
    shr     edi,03h
    xor     ecx,ecx                                     ;创建Static控件（AutoCAD 2008 Internal MText Clipboard Data:）
    mov     qword ptr[rsp+58h],rcx
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],rcx
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],edi
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],ebp
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50000000h
    lea     r8,[ctrlstatic0]
    lea     rdx,[ctrlstatic]
    call    qword ptr[__imp_CreateWindowExW]
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     eax,[ebx+ebx*4+04h]                         ;创建Static控件（AutoCAD Unicode Dimension Clipboard Data:）
    shr     eax,03h
    add     eax,ebx
    xor     ecx,ecx
    mov     qword ptr[rsp+58h],rcx
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],rcx
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],edi
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],eax
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50000000h
    lea     r8,[ctrlstatic1]
    lea     rdx,[ctrlstatic]
    call    qword ptr[__imp_CreateWindowExW]
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     eax,[ebx+ebx*4]                             ;创建Static控件（AutoCAD Unicode Dimension Alt Clipboard Data:）
    add     eax,eax
    lea     eax,[ebx+eax*8+10h]
    shr     eax,05h
    xor     ecx,ecx
    mov     qword ptr[rsp+58h],rcx
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],rcx
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],edi
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],eax
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50000000h
    lea     r8,[ctrlstatic2]
    lea     rdx,[ctrlstatic]
    call    qword ptr[__imp_CreateWindowExW]
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     eax,[ebx+02h]                               ;创建Edit控件（AutoCAD 2008 Internal MText Clipboard Data:）
    shr     eax,02h
    lea     ecx,[ebx+ebx*4+08h]
    shr     ecx,04h
    add     ecx,ebx
    xor     r8d,r8d
    mov     qword ptr[rsp+58h],r8
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],r8
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],ecx
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],eax
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50200004h
    lea     rdx,[ctrledit]
    mov     ecx,00000200h
    call    qword ptr[__imp_CreateWindowExW]
    mov     qword ptr[hwndsubctrl+00h],rax              ;保存控件句柄
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     eax,[ebx+ebx*2]                             ;创建Edit控件（AutoCAD Unicode Dimension Clipboard Data:）
    lea     eax,[ebx+eax*8+10h]
    shr     eax,05h
    add     eax,ebx
    lea     ecx,[ebx+ebx*4]
    lea     ecx,[ebx+ecx*2+08h]
    shr     ecx,04h
    xor     r8d,r8d
    mov     qword ptr[rsp+58h],r8
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],r8
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],ecx
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],eax
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50200004h
    lea     rdx,[ctrledit]
    mov     ecx,00000200h
    call    qword ptr[__imp_CreateWindowExW]
    mov     qword ptr[hwndsubctrl+08h],rax              ;保存控件句柄
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     eax,[ebx+ebx*4]                             ;创建Edit控件（AutoCAD Unicode Dimension Alt Clipboard Data:）
    lea     eax,[ebx+eax*4]
    lea     eax,[ebx+eax*2+08h]
    shr     eax,04h
    lea     ecx,[ebx+ebx*4]
    lea     ecx,[ebx+ecx*2+08h]
    shr     ecx,04h
    xor     r8d,r8d
    mov     qword ptr[rsp+58h],r8
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],r8
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],ecx
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],eax
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50200004h
    lea     rdx,[ctrledit]
    mov     ecx,00000200h
    call    qword ptr[__imp_CreateWindowExW]
    mov     qword ptr[hwndsubctrl+10h],rax              ;保存控件句柄
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     esi,[ebx+ebx*2]                             ;结合DPI计算按钮的宽度，50个单位
    lea     esi,[ebx+esi*8+10h]
    shr     esi,05h
    lea     edi,[ebx+ebx*2]                             ;结合DPI计算按钮的高度，14个单位
    lea     edi,[ebx+edi*2+10h]
    shr     edi,05h
    mov     ebx,dword ptr[r14+0Ch]                      ;结合DPI计算按钮垂直方向的位置，222个单位
    sub     ebx,ebp
    sub     ebx,edi
    xor     ecx,ecx                                     ;创建Button控件（读取）
    mov     qword ptr[rsp+58h],rcx
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],rcx
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],edi
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],ebx
    mov     dword ptr[rsp+20h],ebp
    mov     r9d,50000000h
    lea     r8,[ctrlbutton0]
    lea     rdx,[ctrlbutton]
    call    qword ptr[__imp_CreateWindowExW]
    mov     qword ptr[hwndsubctrl+18h],rax              ;保存控件句柄
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    lea     eax,[esi+ebp*2]                             ;创建Button控件（写入）
    xor     ecx,ecx
    mov     qword ptr[rsp+58h],rcx
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],rcx
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],edi
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],ebx
    mov     dword ptr[rsp+20h],eax
    mov     r9d,50000000h
    lea     r8,[ctrlbutton1]
    lea     rdx,[ctrlbutton]
    call    qword ptr[__imp_CreateWindowExW]
    mov     qword ptr[hwndsubctrl+20h],rax              ;保存控件句柄
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    mov     eax,dword ptr[r14+08h]                      ;创建Button控件（退出）
    sub     eax,ebp
    sub     eax,esi
    xor     ecx,ecx
    mov     qword ptr[rsp+58h],rcx
    mov     qword ptr[rsp+50h],r13
    mov     qword ptr[rsp+48h],rcx
    mov     qword ptr[rsp+40h],r12
    mov     dword ptr[rsp+38h],edi
    mov     dword ptr[rsp+30h],esi
    mov     dword ptr[rsp+28h],ebx
    mov     dword ptr[rsp+20h],eax
    mov     r9d,50000000h
    lea     r8,[ctrlbutton2]
    lea     rdx,[ctrlbutton]
    call    qword ptr[__imp_CreateWindowExW]
    mov     qword ptr[hwndsubctrl+28h],rax              ;保存控件句柄
    xor     r9d,r9d                                     ;设置字体
    mov     r8,qword ptr[r14]                           ;HFONT
    mov     edx,30h                                     ;WM_SETFONT
    mov     rcx,rax                                     ;HWND
    call    qword ptr[__imp_SendMessageW]
    mov     rcx,r12                                     ;主窗口句柄hwnd
    mov     r14,qword ptr[rsp+60h]                      ;还原非易失性寄存器
    mov     r13,qword ptr[rsp+68h]
    mov     r12,qword ptr[rsp+70h]
    add     rsp,50h                                     ;释放部分堆栈空间，仅保留28h大小，便于直接跳转到“读取”按钮的响应代码
    jmp     $2                                          ;直接跳转到“读取”按钮的响应代码，实现启动时默认读取当前剪切板内容
$0: cmp     edx,02h                                     ;WM_DESTROY
    jne     $1
    sub     rsp,28h
    xor     ecx,ecx
    call    qword ptr[__imp_PostQuitMessage]
    add     rsp,28h
    xor     eax,eax
    ret
$1: cmp     edx,0111h                                   ;WM_COMMAND
    jne     $M
    cmp     qword ptr[hwndsubctrl+18h],r9               ;判断是否为“读取”按钮
    jne     $7
    mov     qword ptr[rsp+20h],rbx                      ;响应“读取”按钮
    mov     qword ptr[rsp+18h],rbp
    mov     qword ptr[rsp+10h],rsi
    mov     qword ptr[rsp+08h],rdi
    sub     rsp,28h
$2: mov     qword ptr[rsp+20h],rcx                      ;hwnd，仅在错误提示时使用，所以大概率用不上，没必要占用一个寄存器
    call    qword ptr[__imp_OpenClipboard]
    test    eax,eax                                     ;BOOL类型返回值，标识是否打开成功
    je      $D                                          ;剪切板打开失败则跳转提示
    mov     bx,04h                                      ;开始读取剪切板
    lea     rsi,[clipboardid]                           ;剪切板ID
    lea     rdi,[hwndsubctrl]                           ;编辑框控件句柄
$3: mov     ecx,dword ptr[rsi]                          ;剪切板ID
    call    qword ptr[__imp_IsClipboardFormatAvailable]
    test    eax,eax                                     ;BOOL类型返回值，标识剪切板是否可用
    je      $6                                          ;剪切板不可用则跳转（非失败场景，将对应编辑框内容清空）
    mov     ecx,dword ptr[rsi]                          ;剪切板ID
    call    qword ptr[__imp_GetClipboardData]
    test    rax,rax                                     ;HANDLE类型返回值，标识剪切板数据（hGlobal）
    je      $5                                          ;剪切板数据获取失败（失败场景，需要置上对应比特位来记录错误，并将对应编辑框内容清空）
    mov     rbp,rax                                     ;hGlobal
    mov     rcx,rax                                     ;hGlobal
    call    qword ptr[__imp_GlobalLock]                 ;锁定hGlobal数据
    test    rax,rax                                     ;指针类型返回值，指向hGlobal数据（lpMem）
    je      $5                                          ;hGlobal数据锁定失败（失败场景，需要置上对应比特位来记录错误，并将对应编辑框内容清空）
    mov     r9,rax                                      ;lParam（lpMem）
    xor     r8d,r8d                                     ;wParam（NULL）
    mov     edx,0000000Ch                               ;WM_SETTEXT
    mov     rcx,qword ptr[rdi]                          ;编辑框控件句柄
    call    qword ptr[__imp_SendMessageW]               ;将剪切板内容设置到编辑框控件上
    mov     rcx,rbp                                     ;hGlobal
    call    qword ptr[__imp_GlobalUnlock]               ;解锁hGlobal
$4: add     rsi,04h                                     ;迭代到下一个剪切板ID
    add     rdi,08h                                     ;迭代到下一个编辑框控件句柄
    shr     bl,01h
    jne     $3
    call    qword ptr[__imp_CloseClipboard]             ;三个剪切板都读取完毕了，关闭剪切板
    test    bh,bh                                       ;开始检查是否有剪切板读取失败
    je      $J                                          ;没有剪切板失败，直接跳转返回
    lea     rax,[msgreadclip]                           ;字符串“读取剪切板失败：”，用于创建错误提示弹框
    jmp     $F                                          ;跳转创建错误提示弹窗
$5: or      bh,bl                                       ;置上比特位标记来记录读取失败的剪切板，用于读取完毕后的错误提示
$6: xor     r9d,r9d                                     ;lParam（NULL）
    xor     r8d,r8d                                     ;wParam（NULL）
    mov     edx,0000000Ch                               ;WM_SETTEXT
    mov     rcx,qword ptr[rdi]                          ;编辑框控件句柄
    call    qword ptr[__imp_SendMessageW]               ;将编辑框控件置空
    jmp     $4                                          ;继续迭代处理下一个剪切板
$7: cmp     qword ptr[hwndsubctrl+20h],r9               ;判断是否为“写入”按钮
    jne     $K
    mov     qword ptr[rsp+20h],rbx                      ;响应“写入”按钮
    mov     qword ptr[rsp+18h],rbp
    mov     qword ptr[rsp+10h],rsi
    mov     qword ptr[rsp+08h],rdi
    sub     rsp,28h
    mov     qword ptr[rsp+20h],rcx                      ;hwnd，仅在错误提示时使用，所以大概率用不上，没必要占用一个寄存器
    call    qword ptr[__imp_OpenClipboard]
    test    eax,eax                                     ;BOOL类型返回值，标识是否打开成功
    je      $D                                          ;剪切板打开失败则跳转提示
    call    qword ptr[__imp_EmptyClipboard]
    test    eax,eax                                     ;BOOL类型返回值，标识是否清空成功
    je      $C                                          ;剪切板清空失败则跳转提示
    sub     rsp,10h                                     ;分配暂存r12的空间
    mov     qword ptr[rsp+28h],r12                      ;暂存r12
    mov     bx,04h                                      ;开始写入剪切板
    lea     rsi,[clipboardid]                           ;剪切板ID
    lea     rdi,[hwndsubctrl]                           ;编辑框控件句柄
$8: xor     r9d,r9d                                     ;lParam（NULL）
    xor     r8d,r8d                                     ;wParam（NULL）
    mov     edx,0000000Eh                               ;WM_GETTEXTLENGTH
    mov     rcx,qword ptr[rdi]                          ;编辑框控件句柄
    call    qword ptr[__imp_SendMessageW]               ;获取编辑框内容的长度
    test    rax,rax                                     ;判断编辑框内容的长度
    je      $9                                          ;编辑框内容为空时跳转，不需要设置剪切板
    lea     r12,[rax+01h]                               ;编辑框内字符数，包括结束符（iCount）
    lea     rdx,[r12+r12]                               ;dwBytes（编辑框内字符数*2）
    mov     ecx,02h                                     ;GMEM_MOVEABLE
    call    qword ptr[__imp_GlobalAlloc]                ;分配剪切板全局数据
    test    rax,rax                                     ;HANDLE类型返回值，标识剪切板数据（hGlobal）
    je      $B                                          ;剪切板数据分配失败（失败场景，需要置上对应比特位来记录错误）
    mov     rbp,rax                                     ;hGlobal
    mov     rcx,rax                                     ;hGlobal
    call    qword ptr[__imp_GlobalLock]                 ;锁定hGlobal数据
    test    rax,rax                                     ;指针类型返回值，指向hGlobal数据（lpMem）
    je      $A                                          ;hGlobal数据锁定失败（失败场景，需要置上对应比特位来记录错误，并释放掉hGlobal）
    mov     r9,rax                                      ;lParam（lpMem）
    mov     r8,r12                                      ;wParam（iCount）
    mov     edx,0000000Dh                               ;WM_GETTEXT
    mov     rcx,qword ptr[rdi]                          ;编辑框控件句柄
    call    qword ptr[__imp_SendMessageW]               ;获取编辑框内容
    mov     rcx,rbp                                     ;hGlobal
    call    qword ptr[__imp_GlobalUnlock]               ;解锁hGlobal
    mov     rdx,rbp                                     ;hGlobal
    mov     ecx,dword ptr[rsi]                          ;剪切板ID
    call    qword ptr[__imp_SetClipboardData]           ;设置剪切板数据
    test    rax,rax                                     ;通过返回的句柄判断是否设置成功
    je      $A                                          ;返回值为空，设置失败（失败场景，需要置上对应比特位来记录错误，并释放掉hGlobal）
$9: add     rsi,04h                                     ;迭代到下一个剪切板ID
    add     rdi,08h                                     ;迭代到下一个编辑框控件句柄
    shr     bl,01h
    jne     $8
    mov     r12,qword ptr[rsp+28h]                      ;还原r12
    add     rsp,10h                                     ;释放暂存r12的空间
    call    qword ptr[__imp_CloseClipboard]             ;三个剪切板都读取完毕了，关闭剪切板
    test    bh,bh                                       ;开始检查是否有剪切板写入失败
    je      $J                                          ;没有剪切板失败，直接跳转返回
    lea     rax,[msgwritclip]                           ;字符串“写入剪切板失败：”，用于创建错误提示弹框
    jmp     $F                                          ;跳转创建错误提示弹窗
$A: mov     rcx,rbp                                     ;hGlobal
    call    qword ptr[__imp_GlobalFree]                 ;释放hGlobal
$B: or      bh,bl                                       ;将编辑框控件置空
    jmp     $9                                          ;继续迭代处理下一个剪切板
$C: lea     rdx,[msgeptyclip]                           ;清空剪切板失败错误提示
    jmp     $E
$D: lea     rdx,[msgopenclip]                           ;打开剪切板失败错误提示
$E: mov     r9d,00000030h
    lea     r8,[msgtitle1]
    mov     rcx,qword ptr[rsp+20h]
    call    qword ptr[__imp_MessageBoxW]
    jmp     $J
$F: mov     rbp,rsp                                     ;读取/写入剪切板失败错误提示
    sub     rsp,12h
    mov     word ptr[rsp+30h],00h
    test    bh,01h                                      ;检查三号剪切板
    je      $G
    sub     rsp,5Ah                                     ;(44+1)*2
    lea     rsi,[clipname2]
    lea     rdi,[rsp+32h]
    mov     ecx,16h
    rep     movsd
    mov     word ptr[rsp+30h],000Ah
$G: test    bh,02h                                      ;检查二号剪切板
    je      $H
    sub     rsp,52h                                     ;(40+1)*2
    lea     rsi,[clipname1]
    lea     rdi,[rsp+32h]
    mov     ecx,14h
    rep     movsd
    mov     word ptr[rsp+30h],000Ah
$H: test    bh,04h                                      ;检查一号剪切板
    je      $I
    sub     rsp,56h                                     ;(42+1)*2
    lea     rsi,[clipname0]
    lea     rdi,[rsp+32h]
    mov     ecx,15h
    rep     movsd
    mov     word ptr[rsp+30h],000Ah
$I: mov     rsi,rax
    lea     rdi,[rsp+20h]
    mov     ecx,02h
    rep     movsq
    mov     r9d,00000030h
    lea     r8,[msgtitle1]
    lea     rdx,[rsp+20h]
    mov     rcx,qword ptr[rbp+20h]                      ;hwnd
    and     rsp,0FFFFFFFFFFFFFFF0h
    call    qword ptr[__imp_MessageBoxW]
    mov     rsp,rbp
$J: add     rsp,28h
    mov     rdi,qword ptr[rsp+08h]
    mov     rsi,qword ptr[rsp+10h]
    mov     rbp,qword ptr[rsp+18h]
    mov     rbx,qword ptr[rsp+20h]
    xor     eax,eax
    ret
$K: cmp     qword ptr[hwndsubctrl+28h],r9               ;判断是否为“退出”按钮
    jne     $N
$L: sub     rsp,28h
    call    qword ptr[__imp_DestroyWindow]
    add     rsp,28h
    xor     eax,eax
    ret
$M: cmp     edx,0112h                                   ;WM_SYSCOMMAND
    jne     $N
    mov     rax,r8
    and     ax,0FFF0h
    cmp     ax,0F060h
    je      $L
$N: jmp     qword ptr[__imp_DefWindowProcW]
winproc endp
end
