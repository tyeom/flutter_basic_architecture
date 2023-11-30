# Flutter basic clean architecture demo app

### This project is based on Flutter and implements and explains simple functions aimed at basic Clean Architecture design.
### 이 프로젝트는 Flutter 기반으로 기본적인 Clean Architecture 설계를 목표로한 간단한 기능이 구현 되어 있고, 설명 하고 있습니다.

- blog post : [Flutter - Clean Architecture 적용해보기](https://blog.arong.info/flutter/2023/11/29/Flutter-Clean-Architecture-%EC%A0%81%EC%9A%A9%ED%95%B4%EB%B3%B4%EA%B8%B0.html)

Project Architecture
-
![플러터_클린아키텍처_구조](https://github.com/tyeom/flutter_basic_architecture/assets/13028129/97b2e130-733a-43b0-8317-cf1dfd24d319)

> **※ Incorrect orientation of the 'Import to' arrow in the architectural diagram.**<br/>
> [Presentaion Module] 에서 ~Bloc -> [Domain Module] Use Case~ → [Domain Module] Use Case -> [Presentaion Module] Bloc <br/>
> [Data Module] 에서 ~Translator -> [Domain Module] Model~ → [Momain Module] Model -> [Data Module] Translator <br/>

Project solution structure
-

├─**App** - App initial settings<br/>
├─**Data**<br/>
│  ├─**data_source** - API requestbr/>
│  ├─**network** - http request module<br/>
│  ├─**repository** - Implementation of actual data request processing<br/>
│  ├─**responses** - data entity<br/>
│  └─**translator** - Domain layer Model Mapper<br/>
├─**Domain**<br/>
│  ├─**models** - Data Model<br/>
│  ├─**repository** - Business logic abstraction<br/>
│  ├─**request** - Data request information<br/>
│  └─**usecase** - Either Concepts (Left - Failure) / (Right - Success), UseCase definition<br/>
├─**Injectable** - Initialize injectable<br/>
├─**l10n**<br/>
│  └─arb<br/>
└─**Presentation** - UI(Login, Data List, Simple page routing, skeleton loading)<br/>
    ├─**authentication**<br/>
    │  └─**bloc** - Authentication-related UI business logic<br/>
    ├─**component** - common widgets<br/>
    ├─**home**<br/>
    │  ├─**bloc** - Main home UI business logic<br/>
    │  └─**view** - Main home UI<br/>
    ├─**login**<br/>
    │  ├─**bloc** - Login UI business logic<br/>
    │  ├─**forms** - Login user input forms (used in the forms package)<br/>
    │  └─**view** - Login UI<br/>
    ├─**splash** - splash UI<br/>
    └─**subscription_info**<br/>
        ├─**bloc**<br/>
        └─**view**<br/>

Packages
-

- get_it
- injectable
- flutter_bloc
- dio
- pretty_dio_logger
- equatable
- dartz
- json_annotation
- json_serializable
- retrofit
- formz
- shared_preferences
- flutter_secure_storage
- flutter_speed_dial
- bottom_sheet
- shimmer

<br/>

> **This project implements various functions in basic app implementation.**

> **이 프로젝트는 기본적인 앱 구현에 있어 필요한 다양한 기능들이 구현 되어 있습니다.**<br/>
> (반응형 UI처리, skeleton loading 효과, 다국어 처리, BLoC를 통한 상태 관리, Dio Interceptor를 통한 API Access token 인증 처리, API Access token 만료시 재발급 로직 설명 등)

***

how to use tha app?
-

![Clean_Architecture_Flutter](https://github.com/tyeom/flutter_basic_architecture/assets/13028129/57450296-226d-48d6-bb61-b96dd614dfd9)

### for *login* use the following data
```
{
  "Id":"test",
  "Password":"1234"
}
